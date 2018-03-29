//
//  NoMoneyPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

enum  NoMoneyPageType {
    case post_content
    case create_circle
    case join_circle
}

class NoMoneyPage: BaseViewController {

    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var noMnoneyTitle: UILabel!
    @IBOutlet weak var lockPstWarn: UILabel!
    @IBOutlet weak var costLock: UILabel!
    @IBOutlet weak var chargeButton: UIButton!
    var disPlay: NoMoneyPageType = .post_content
    
    override func viewDidLoad() {
        super.viewDidLoad()

        maskView.setCornerRadius(radius: 12)
        chargeButton.setCornerRadius(radius: 19)
        noMnoneyTitle.text = Rstring.no_pst_warn.localized()
        lockPstWarn.text = Rstring.post_article_title.localized() + " " + "20 PST"
        costLock.text = Rstring.post_transfor_pst.localized() + "0"
        chargeButton.setTitle(Rstring.go_to_charge.localized(), for: .normal)
        
        self.view.backgroundColor = UIColor.clear
        maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
        
        switch disPlay {
        case .post_content:
            lockPstWarn.text = Rstring.post_article_title.localized() + " " + POST_ARTICLE_PST + " PST"
            break
        case .create_circle:
            lockPstWarn.text = Rstring.cycle_create_lock.localized() + " " + CREATE_CIRCLE_PST + " PST"
            break
        case .join_circle:
            lockPstWarn.text = Rstring.cycle_join_lock.localized() + " " + JOIN_CIRCLE_PST + " PST"
            break
        }
        
        UserAPI.getUserInfo(
            Address:nil,
            suc: { (userModel) in
                self.costLock.text = Rstring.post_transfor_pst.localized() +  " " + (userModel.Balance?.toPstValue())!
        }) { (error) in
            debugPrint(error)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: animationTime) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.maskView.transform = CGAffineTransform.identity
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Outlet action
    @IBAction func chargeBuuton(_ sender: Any) {
        
    }
    
    @IBAction func closePage(_ sender: Any) {
        UIView.animate(withDuration: animationTime, animations: {
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
}
