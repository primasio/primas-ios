//
//  FeedBackPage.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/8.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

// MARK: - Selector
extension Selector {
    static let postFeedBack = #selector(FeedBackPage.post)
    static let keyboardShow = #selector(FeedBackPage.keyboardShow)
    static let keyboardHide = #selector(FeedBackPage.keyboardHide)
}

class FeedBackPage: BaseViewController {

    fileprivate let bottomMargin: CGFloat = 20
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var content: RSKPlaceholderTextView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var bottomH: NSLayoutConstraint!
    var isLoad = false
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        content.delegate = self
        redView.isHidden = true
        email.placeholder = Rstring.common_EMAIL.localized()
        content.placeholder = Rstring.feed_BACK_PROMPT.localized() as NSString
        self.navigationItem.title = Rstring.set_SUGGES_TITLE.localized()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(
            title: Rstring.common_SUBMIT.localized(),
            style: .plain,
            target: self,
            action: .postFeedBack)
        X_Notification.addObserver(
            self,
            selector: .keyboardShow,
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil)
        X_Notification.addObserver(
            self,
            selector: .keyboardHide,
            name: NSNotification.Name.UIKeyboardDidHide,
            object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        KeyboardManager.enAbleDoneButton(enAble: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
        KeyboardManager.enAbleDoneButton()
    }
    
    @objc func post()  {
        
        guard isLoad == false else { return }
        
        let emailText = email.text
        let contentText = content.text
        
        guard !(emailText?.isEmpty)! else {
            hudShow(Rstring.common_EMPTY_EMAIL.localized())
            return
        }
        guard Validate.email(emailText!).isRight else {
            hudShow(Rstring.common_ERROR_EMAIL.localized())
            return
        }
        guard !(contentText?.isEmpty)! else {
            hudShow(Rstring.feed_BACK_PROMPT.localized())
            return
        }
        
        self.view.endEditing(true)
        let hud = hudLoading()
        hud.isUserInteractionEnabled = true
        
        isLoad = true
        
        OthersAPI.submitFeedback(
            email: emailText!,
            feedback: contentText!,
            suc: {
                self.hudHide()
                self.hudShow("FEEDBACK_SUCCEED".localized)
                Utility.delay(1) {
                    self.isLoad = false
                    self.navigationController?.popViewController(animated: true)
                }
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            self.hudShow(error.localizedDescription)
            self.isLoad = false
        }
        
    }
    
    // MARK: - Listening keyboard
    @objc  func keyboardShow(notification: NSNotification)  {
        if let infoKey  = notification.userInfo?[UIKeyboardFrameEndUserInfoKey],
            let rawFrame = (infoKey as AnyObject).cgRectValue {
            let keyboardFrame = view.convert(rawFrame, from: nil)
            var heightKeyboard = keyboardFrame.size.height
            if IS_iPhoneX {
                heightKeyboard = heightKeyboard - CGFloat.init(IPHONEX_BOTTOM)
            }
            let height = bottomMargin + heightKeyboard
            bottomH.constant = height
        }
    }

    @objc func keyboardHide()  {
        bottomH.constant = bottomMargin
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

extension FeedBackPage: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        redView.isHidden = false
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        redView.isHidden = true
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        content.becomeFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            post()
            return false
        }
        return true
    }
    
}

