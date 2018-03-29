//
//  NoticeLogin.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/25.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

enum NoticeLogin_Style {
    case NoticeLogin_homePage
    case NoticeLogin_minePage
}

class NoticeLogin: BaseViewController {

    var display:NoticeLogin_Style = .NoticeLogin_homePage
    var createAction:NoneBlock?
    var settingAction:NoneBlock?

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var createAccount: UIButton!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var settingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createAccount.setTitle(Rstring.common_create_account.localized().localized,
                               for: .normal)
        switch display {
        case .NoticeLogin_homePage:
            showLabel.text = Rstring.common_create_prompt.localized()
            logoImg.image = Rimage.quexun_1()
            settingBtn.isHidden = true
            break
        case .NoticeLogin_minePage:
            viewTop.constant = UIDevice.navTopOffset() - 44
            settingBtn.isHidden = false
            showLabel.text = Rstring.common_create_prompt2.localized()
            logoImg.image = Rimage.userLogo()
            
            self.settingBtn.addAction(.touchUpInside, action: {
                if self.settingAction != nil {
                    self.settingAction!()
                }
            })
            
            break
        }
        
        self.createAccount.addAction(.touchUpInside) {
            if self.createAction != nil { self.createAction!()  }
        }
        
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
