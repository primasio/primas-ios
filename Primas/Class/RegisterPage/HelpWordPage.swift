//
//  HelpWordPage.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/14.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot

class HelpWordPage: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeContent: UILabel!
    @IBOutlet weak var mnemonicText: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    
    open var mnonicPhrase = ""
    
    // Set StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return.lightContent }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "MNEMONIC_BACK_TITLE".localized
        noticeLabel.text =  "MNEMONIC_BACK_NOTICE".localized

        let common_style = StringStyle(
            .font(UIFont.systemFont(ofSize: 15)),
            .color(Color_EAB830),
            .lineSpacing(2))
        noticeContent.attributedText = Rstring.mnemonic_BACK_WARN.localized().styled(with: common_style)
        completeBtn.setTitle("CONFIRM_BUTTON".localized, for: .normal)
        
        let word_style = StringStyle(
            .font(UIFont.systemFont(ofSize: 18)),
            .color(UIColor.white),
            .lineSpacing(5))
        mnemonicText.attributedText = mnonicPhrase.styled(with: word_style)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func popAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionButton(_ sender: Any) {
        let vc = Rstoryboard.builtWallet.checkHelpWord()!
        vc.tempString = mnonicPhrase
        self.navigationController?.pushViewController(vc, animated: true)
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
