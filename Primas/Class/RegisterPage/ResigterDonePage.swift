//
//  ResigterDonePage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class ResigterDonePage: BaseViewController {

    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var successImg: UIImageView!
    @IBOutlet weak var userNameTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressQrcode: UIImageView!
    @IBOutlet weak var qrcodeTitle: UILabel!
    @IBOutlet weak var bottomButtom: UIButton!
    @IBOutlet weak var pstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maskView.setCornerRadius(radius: 12)
        bottomButtom.setCornerRadius(radius: 5)
        
        UserTool.shared.getUserModel(handle: { (userModel) in
            let addressString = userModel.Address
            self.userNameTitle.text = Rstring.common_username.localized()
            self.userName.text = userModel.Name
            self.timeTitle.text = Rstring.common_register_time.localized()
            self.time.text = userModel.CreatedAt?.toTimeString()
            self.addressTitle.text = Rstring.common_account_address.localized()
            self.address.text = addressString
            self.qrcodeTitle.text = Rstring.common_account_qrcode.localized()
            self.pstLabel.text = Rstring.common_pst_notice.localized()
            self.bottomButtom.setTitle(Rstring.common_quick_look.localized(), for: .normal)
            self.addressQrcode.image = addressString?.generateQRCode()
        }) { (error) in
            self.hudShow(error.localizedDescription)
        }
        
        self.view.backgroundColor = UIColor.clear
        maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: animationTime) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.maskView.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - outlet action
    @IBAction func cloasePage(_ sender: Any) {
        UIView.animate(withDuration: animationTime, animations: {
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @IBAction func bottomAction(_ sender: Any) {
        UIView.animate(withDuration: animationTime, animations: {
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: {
                    X_Notification.post(GET_Notification(.go_value_page))
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
