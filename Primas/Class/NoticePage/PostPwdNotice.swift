//
//  PostPwdNotice.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit


enum pwdType {
    case usePst
    case useHp
}

class PostPwdNotice: BaseViewController {
    
    var pwdBlock:StringBlock?
    var display:pwdType = .usePst
    var costValue = "0"
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var pstTitle: UILabel!
    @IBOutlet weak var costPst: UILabel!
    @IBOutlet weak var pwdView: UIView!
    @IBOutlet weak var pwdTextFiled: UITextField!
    @IBOutlet weak var lockLabel: UILabel!
    @IBOutlet weak var lockTimeLabel: UILabel!
    @IBOutlet weak var bottomLine: NSLayoutConstraint!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // ui 
        maskView.setCornerRadius(radius: 12)
        pwdView.setCornerRadius(radius: 2)
        pwdView.setBorderWidth(width: 0.5)
        pwdView.setBorderColor(color: Rcolor.e6E6E6())
        
        if display == .usePst {
            postTitle.text = Rstring.post_article_title.localized()
            pstTitle.text =  costValue  + " " + Rstring.common_Pst.localized()
            costPst.text = Rstring.post_transfor_pst.localized()  + " " + "0"
            lockLabel.text = Rstring.lock_pst_warn.localized()
            lockTimeLabel.text = ""

            ValueAPI.getBalance(suc: { (value) in
                self.costPst.text = Rstring.post_transfor_pst.localized()  + " " + value
            }, err: { (error) in
                debugPrint(error)
                self.hudShow(error.localizedDescription)
            })
            
            if costValue == JOIN_CIRCLE_PST {
                postTitle.text = Rstring.cycle_join_lock.localized()
            }
            
        } else {
            
            lockTimeLabel.isHidden = true
            iconImage.image = Rimage.xiaohao()
            postTitle.text = Rstring.post_usdHp_warn.localized()
            pstTitle.text =  ""
            costPst.text = Rstring.notice_current_hp.localized() + " " + "0"
            lockLabel.text = Rstring.notice_hp_prompt.localized()
            
            ValueAPI.getHP(suc: { (hp) in
                self.costPst.text = Rstring.notice_current_hp.localized() + " " + hp
            }, err: { (errro) in
                debugPrint(errro)
            })
        }
                
        bottomLine.constant = Utility.getKeyboardHeight() + 57
        pwdTextFiled.delegate = self
        pwdTextFiled.placeholder = Rstring.notice_input_pwd.localized()
        pwdTextFiled.addTarget(self, action: #selector(textFiledEdit),
                               for: .editingChanged)
        pwdTextFiled.font = UIFont.systemFont(ofSize: 16)
        self.view.backgroundColor = UIColor.clear
        maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: animationTime) {
            self.pwdTextFiled.becomeFirstResponder()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.maskView.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - outlet action
    
    @IBAction func closePage(_ sender: Any) {
        UIView.animate(withDuration: animationTime, animations: {
            self.pwdTextFiled.resignFirstResponder()
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc func textFiledEdit() {
        let input = pwdTextFiled.text
        if (input?.isEmpty)! {
            pwdView.setBorderColor(color: Rcolor.e6E6E6())
        } else {
            pwdView.setBorderColor(color: Rcolor.ed5634())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PostPwdNotice:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)! {
            if pwdBlock != nil { pwdBlock!(textField.text!) }
            closePage(self)
        } else {
            self.hudShow(Rstring.input_PWD_TITLE.localized())
        }
        return true
    }
}
