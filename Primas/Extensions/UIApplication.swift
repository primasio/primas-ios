//
//  UIApplication.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/24.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    // MARK: - Get topViewController
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
