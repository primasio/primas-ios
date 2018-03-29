//
//  CheckHelpWord.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/14.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot

class CheckHelpWord: UIViewController {

    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var textholder: UILabel!
    
    open var tempString = ""
    
    // Set StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return.lightContent }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navTitle.text = "CHECK_MNEMONIC_TITLE".localized
        doneBtn.setTitle("FINISH_BUTTON".localized, for: .normal)
        checkLabel.text = "MNEMONIC_TEXT_ERROR".localized
        textholder.text = "MNEMONIC_SUB_Holder".localized
        
        checkLabel.isHidden = true
        X_Notification.addObserver(self, selector: #selector(checkWords),
                                   name: NSNotification.Name.UITextViewTextDidChange,
                                   object: nil)
        inputTextView.inputAccessoryView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    @objc func checkWords()  {
        let input = inputTextView.text
        textholder.isHidden = !(input?.isEmpty)!
        
        /*
        if input?.split(separator: " ").count == 12 {
            if !(input?.isEmpty)! && input ==  tempString {
                checkLabel.isHidden = true
            } else {
                checkLabel.isHidden = false
            }
        }
        */
        
        let word_style = StringStyle(
            .font(UIFont.systemFont(ofSize: 18)),
            .color(UIColor.white),
            .lineSpacing(5))

        inputTextView.attributedText = inputTextView.text.lowercased().styled(with: word_style)
    }
    
    @IBAction func popAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishButton(_ sender: Any) {
        let input = inputTextView.text
        guard !(input?.isEmpty)! else {
            self.hudShow("MNEMONIC_SUB_Holder".localized)
            return
        }

        guard input == tempString else  {
            self.hudShow("MNEMONIC_TEXT_ERROR".localized)
            return
        }
        self.view.endEditing(true)
        X_Notification.post(GET_Notification(.register_Finish))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
