//
//  UpdatePage.swift
//  Primas
//
//  Created by figs on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class UpdatePage: BaseViewController {

    var userModel: UserModel?
    
    let nameInput = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Rstring.mine_name_update.localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: Rstring.finish_BUTTON.localized(), style: UIBarButtonItemStyle.done, target: self, action: #selector(onFinishAction))
        // Do any additional setup after loading the view.
        var rect = self.view.bounds
        rect.origin.y = UIDevice.navTopOffset()
        rect.size.height = 50
        nameInput.frame = rect
        nameInput.rightView = UIImageView.init(image: Rimage.delete_icon())
        nameInput.rightViewMode = .whileEditing
        nameInput.font = UIFont.systemFont(ofSize: 15)
        nameInput.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 15, height: nameInput.height))
        nameInput.leftViewMode = .always
        nameInput.textColor = Color_51
        self.view.addSubview(nameInput)
        
        UserTool.shared.getUserModel(handle: { (user) in
            self.nameInput.text = user.Name
        }, err: { _ in
            
        })
        
        nameInput.addTarget(self, action: #selector(textChanged(tf:)), for: UIControlEvents.editingChanged)
        
        nameInput.addBorder(color: Color_E5E5E5, size: 0.5, borderTypes: [BorderType.top.rawValue, BorderType.bottom.rawValue])
    }

    
    @objc func onFinishAction(){
        guard (nameInput.text != nil) else {
            self.hudShow(Rstring.contact_NO_NAME.localized())
            return
        }
        
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { pwd in
            UserAPI.updateUserName(name: self.nameInput.text!, passphrase: pwd, suc: { user in
                UserTool.shared.initUserModel(user: user)
                X_Notification.post(name: GET_Notification_Name(.username_updated), object: self.nameInput.text!)
                self.navigationController?.popViewController(animated: true)
                vc.checkPassword(flag: true)
            }) { (error) in
                debugPrint(error)
                if IS_PwdError(error) {
                    vc.checkPassword(flag: false)
                } else {
                    vc.checkPassword(flag: true)
                    self.hudShow(GethErrorLog(error))
                }
            }
        }
        self.navigationController?.presentVc(vc, animated: false)
    }

    
    
    @objc func textChanged(tf: UITextField){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.navigationController!.isNavigationBarHidden {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
