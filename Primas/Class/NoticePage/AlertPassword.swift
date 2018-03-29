//
//  AlertPassword.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/9.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class AlertPassword: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var pwdInputView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var inputText: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var popViewT: NSLayoutConstraint!
    @IBOutlet weak var popView: UIView!
    
    var block:StringBlock? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.text = Rstring.input_PWD_TITLE.localized()
        passwordText.placeholder = "SETTING_PWD".localized
        cancelBtn.setTitle("CANCEL_BUTTON".localized, for: .normal)
        confirmBtn.setTitle("CONFIRM_BUTTON".localized, for: .normal)
        
        self.pwdInputView?.layer.borderWidth = 0.5
        self.pwdInputView?.layer.borderColor = Rcolor.e6E6E6().cgColor
        self.pwdInputView.setCornerRadius(radius: 5)
        passwordText.delegate = self
        passwordText.inputAccessoryView = UIView()
        passwordText.addTarget(self, action: #selector(pwdEditing), for: .editingChanged)
        self.view.backgroundColor = UIColor.clear
        popView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
        if IS_iPhoneSE {  popViewT.constant = 135 }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5) {
            self.popView.transform = CGAffineTransform.identity
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.passwordText.becomeFirstResponder()
        }
    }
    
    @objc func pwdEditing()  {
        if (passwordText.text?.isEmpty)! {
            self.pwdInputView?.layer.borderColor = Rcolor.e6E6E6().cgColor
        } else {
            self.pwdInputView?.layer.borderColor = Rcolor.ed5634().cgColor
        }
    }
    
    // MARK: - IBOutlet Action

    
    @IBAction func confirmAction(_ sender: Any) {
        let pwd = passwordText.text
        if !(pwd?.isEmpty)! {
            passValue(value: pwd!)
        } else {
            self.hudShow("NOTHING_INPUT".localized)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        passwordText.resignFirstResponder()
        self.dismiss(animated: false, completion: nil)
    }
    
    open func checkPassword(flag: Bool)  {
        if flag {
            passwordText.resignFirstResponder()
            self.dismiss(animated: false, completion: nil)
        } else {
            passwordText.text = ""
            self.hudShow("PWD_ERROR".localized)
            pwdEditing()
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let pwd = textField.text
        if !(pwd?.isEmpty)! {
            passValue(value: pwd!)
        }
        return true
    }
    
    func passValue(value: String)  {
        if  !(value.isEmpty) {
            // self.dismiss(animated: false, completion: nil)
            if (block != nil) {
                block!(value)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
