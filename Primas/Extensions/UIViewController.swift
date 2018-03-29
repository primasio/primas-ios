//
//  UIViewController.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    // MARK: - Hidden navigationController
    func hiddenNav(_ isHidden:Bool = true, animated:Bool = true)  {
    self.navigationController?.setNavigationBarHidden(
        isHidden, animated: animated)
    }
    
    // MARK: - Push viewcontroller
    func pushVc(_ vc:UIViewController, animated:Bool = true)  {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    // MARK: - Present viewcontroller
    func presentVc(_ vc:UIViewController, animated:Bool = true)  {
        self.present(vc, animated: animated, completion: nil)
    }
    
    // MARK: - transparent Nav
    func transparentNav()  {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
    }
    
    // MARK: - fix TableView Inset
    open func fixTableViewInset(tableView:UITableView)  {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedSectionFooterHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    
    /// Share
    func activityShare(info:String)  {
        Utility.safeMainQueue {
            let activityItems = [info]
            let activityVC = UIActivityViewController.init(activityItems: activityItems,
                                                           applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityType.print,UIActivityType.assignToContact,UIActivityType.saveToCameraRoll, UIActivityType.airDrop];
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Alert show
    func alertShow(
        title: String? = nil,
        message: String? = nil,
        cancelTitle: String = Rstring.common_Cancel.localized(),
        cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
        comfirmTitle: String,
        comfirmHandle: ((UIAlertAction) -> Swift.Void)? = nil)  {
        let alertVC = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: cancelTitle,
                                             style: .cancel,
                                             handler: cancelHandler))
        alertVC.addAction(UIAlertAction.init(title: comfirmTitle,
                                             style: .destructive,
                                             handler: comfirmHandle))
        let popover = alertVC.popoverPresentationController
        if (popover != nil) {
            popover?.sourceView = self.view
            popover?.sourceRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        }
        self.presentVc(alertVC, animated: true)
    }
    
    // MARK: - Present post viewcontroller
    func presentPostVc() {
        let vc = Rstoryboard.postPage.postMain()!
        presentVc(vc)
    }
    
    // MARK: - Password error handle
    func pwdErrorAlert(_ handle:@escaping NoneBlock)  {
        self.alertShow(
            title: Rstring.pwd_ERROR.localized(),
            cancelHandler: nil,
            comfirmTitle: Rstring.comomon_try_again.localized()) { _ in
                handle()
        }
    }
    
    // MARK: - Judge enough balance
    func enoughBalance(
        usePst: String,
        handle: @escaping (_ flag: Bool) -> ())  {
        guard Have_User() else {
            handle(false)
            return
        }
        // get balance value
        ValueAPI.getBalance(suc: { value in
            let v = value.toDecimalNumber().subtracting(usePst.toDecimalNumber())
            let result = v.intValue >= 0
            handle(result)
        }) { (error) in
            handle(false)
            self.hudShow(error.localizedDescription)
        }
    }
    
    // MARK: - present no pst page
    func presentNoPST(disPlay: NoMoneyPageType)  {
        let vc = Rstoryboard.noticeView.noMoneyPage()!
        vc.disPlay = disPlay
        vc.modalPresentationStyle = .overCurrentContext
        self.presentVc(vc, animated: false)
    }

    func autoPresentNoPST(usePst: String, disPlay: NoMoneyPageType)  {
        enoughBalance(
        usePst: usePst) { (flag) in
            if !flag { self.presentNoPST(disPlay: disPlay) }
        }
    }

}
