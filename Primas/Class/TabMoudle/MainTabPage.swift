//
//  MainTabPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit


class MainTabPage: UITabBarController {
    fileprivate let tagValue =  1000
    fileprivate let  backView = UIView()
    fileprivate var tempButton:UIButton?
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rootVcSet()
        tabbarSet()
    }

    func rootVcSet() {
        let homePageNav = Rstoryboard.homePage.homePageNav()!
        let cyclePageNav = Rstoryboard.cyclePage.cyclePageNav()!
        let worthPageNav = Rstoryboard.worthPage.worthPageNav()!
        let minePageNav = Rstoryboard.minePage.minePageNav()!
        self.viewControllers =
            [
                homePageNav,
                cyclePageNav,
                UIViewController(),
                worthPageNav,
                minePageNav
            ]
    }
    
    // Custom set
    func tabbarSet()  {
        self.tabBar.isTranslucent = false
        let tabCount = tabbarIconNor().count
        let width = kScreenW / CGFloat(tabCount)
        backView.frame = CGRect.init(
            x: 0,
            y: 0,
            width: kScreenW,
            height: 49)
        backView.backgroundColor = UIColor.white
        self.tabBar.addSubview(backView)
        self.tabBar.bringSubview(toFront: backView)
        
        for index in 0...(tabCount - 1) {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(
                x: width * CGFloat(index),
                y: 0,
                width: width,
                height: 45)
            button.tag = tagValue + index
            let normalImg:UIImage = tabbarIconNor()[index]
            let selectImg:UIImage = tabbarIconSel()[index]
            button.setImage(normalImg, for: .normal)
            button.setImage(selectImg, for: .selected)
            button.adjustsImageWhenHighlighted = false
            button.addTarget(
                self,
                action: #selector(didClickButton),
                for: .touchUpInside)
            backView.addSubview(button)
            if index == 0 { didClickButton(button: button) }
        }
    }
    
    /// normal image
    func tabbarIconNor() -> [UIImage] {
        let home = Rimage.shouye()!
        let shenquan = Rimage.shequn()!
        let post = Rimage.fabu()!
        let jiazhi = Rimage.jiazhi()!
        let wode = Rimage.wode()!
        return [home, shenquan, post, jiazhi, wode]
    }
    
    /// select image
    func tabbarIconSel() -> [UIImage] {
        let home_s = Rimage.shouye_1()!
        let shenquan_s = Rimage.shequn_1()!
        let post = Rimage.fabu()!
        let jiazhi_s = Rimage.jiazhi_1()!
        let wode_s = Rimage.wode_1()!
        return [home_s, shenquan_s, post, jiazhi_s, wode_s]
    }
    
    @objc func didClickButton(button: UIButton)  {
        if tempButton == button  { return }
        if button.tag - tagValue == 2 {
            // without loginin
            if !UserTool.shared.haveUser() {
                presentVc(Rstoryboard.builtWallet.builtWallet()!)
                return
            }
            let vc = Rstoryboard.postPage.postMain()!
            presentVc(vc)
            return
        }
        self.selectedIndex = button.tag - tagValue
        self.selectedIndex = button.tag - tagValue
        tempButton?.isSelected = !(tempButton?.isSelected)!
        button.isSelected = !button.isSelected
        tempButton = button
    }
    
    /// show rester success view
     @objc func dissMiss()  {
        Utility.delay(0.5) {
            let vc = Rstoryboard.builtWallet.resigterDonePage()!
            vc.modalPresentationStyle = .overCurrentContext
            self.presentVc(vc, animated: false)
        }
    }
    
    /// go to balance page
    @objc func goValuePage() {
        let button = self.view.viewWithTag(3 + tagValue)
        didClickButton(button: button as! UIButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        X_Notification.addObserver(
            self,
            selector: #selector(MainTabPage.dissMiss),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
        X_Notification.addObserver(
            self,
            selector: #selector(MainTabPage.goValuePage),
            name: GET_Notification_Name(.go_value_page),
            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
