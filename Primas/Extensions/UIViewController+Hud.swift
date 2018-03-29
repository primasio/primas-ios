//
//  UIViewController+Hud.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import MBProgressHUD

extension UIViewController {
    
    // MARK: - HUD Message Show
    open func hudShow(_ content: String, afterDelay: TimeInterval = 1, offset: CGFloat = 0)  {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .text
        hud.contentColor = Color_fafafa
        hud.bezelView.color = Color_ED5634
        hud.animationType = .zoom
        hud.label.text = content
        let margin:CGFloat = 10
        hud.margin = margin
        var nav:CGFloat = 64
        if IS_iPhoneX { nav += 24 }
        hud.offset = CGPoint.init(
            x: 0,
            y: -self.view.center.y  + margin + offset + nav + 20)
        hud.label.numberOfLines = 0
        hud.label.font = UIFont.boldSystemFont(ofSize: 14)
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.setCornerRadius(radius: 5)
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    // MARK: - Loading Message
    open func hudLoading(_ content: String = "Loading") -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = content
        hud.label.numberOfLines = 0
        hud.contentColor = Color_fafafa
        hud.bezelView.color = Color_ED5634
        hud.isUserInteractionEnabled = false
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: TimeInterval(NETWORK_TIMEOUT))
        return hud
    }
    
    // MARK: - Hide HUD Message
    open func hudHide() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
