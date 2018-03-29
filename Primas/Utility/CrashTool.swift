//
//  CrashTool.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

class CrashTool: NSObject {

    // MARK: - set up
    static func setUp() {
        Fabric.with([Crashlytics.self])
    }
    
    /// Use the current user's information
    static func reportUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("xuxiwen785@163.com")
        Crashlytics.sharedInstance().setUserIdentifier("QQ:985515495")
        Crashlytics.sharedInstance().setUserName("xuxiwen")
    }
}
