//
//  NoticeAddTags.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class NoticeAddTags: BaseViewController {
    
    var blockTag:StringBlock?
    
    fileprivate let bottomMargin:CGFloat = 57
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var addTitle: UILabel!
    @IBOutlet weak var textMask: UIView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var textView: RSKPlaceholderTextView!
    @IBOutlet weak var bottomH: NSLayoutConstraint!
    @IBOutlet weak var inputCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maskView.setCornerRadius(radius: 12)
        textMask.setBorderWidth(width: 0.5)
        textMask.setBorderColor(color: Rcolor.e6E6E6())
        addTitle.text = Rstring.common_add_tags.localized()
        confirmBtn.setTitle(Rstring.common_Confirm.localized(), for: .normal)
        cancelBtn.setTitle(Rstring.common_Cancel.localized(), for: .normal)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.placeholder = Rstring.notice_addTags_limit.localized() as NSString
        
        bottomH.constant = Utility.getKeyboardHeight() + bottomMargin
        self.view.backgroundColor = UIColor.clear
        maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
        textView.delegate = self
 
        X_Notification.addObserver(
            self, selector: #selector(contentText),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: animationTime) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.maskView.transform = CGAffineTransform.identity
            self.textView.becomeFirstResponder()
        }
    }

    // close page
    func closePage() {
        UIView.animate(withDuration: animationTime, animations: {
            self.textView.resignFirstResponder()
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    
    @objc func contentText()  {
        let input = textView.text
        if (input?.isEmpty)! {
            inputCount.text = "0 / 24"
            textMask.setBorderColor(color: Rcolor.e6E6E6())

        } else {
            inputCount.text =  "\(input!.count)" + " / 24"
            textMask.setBorderColor(color: Rcolor.ed5634())

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Outlet action
    @IBAction func confirmAction(_ sender: Any) {
        let input = textView.text
        guard !(input?.isEmpty)! else {
            self.hudShow(Rstring.notice_addTags.localized())
            return
        }
        guard input!.count <= 24 else {
            self.hudShow(Rstring.notice_count_limit.localized())
            return
        }
        
        if blockTag != nil { blockTag!(input!) }
        closePage()
    }
    @IBAction func cancelAction(_ sender: Any) {
        closePage()
    }
    
}

extension NoticeAddTags: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.view.endEditing(true)
            confirmAction(self)
        }
        return true
    }
    
    
}

