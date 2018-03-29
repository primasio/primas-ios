//
//  NotifyManage.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/3.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

public enum NotificationName:String {
        case register_Finish = "register_Finish"
        case change_Language = "change_Language"
        case go_value_page = "go_value_page"
        case username_updated = "username_updated"
        case end_post_article = "end_post_article"
}

// MARK: - Get Notification
func GET_Notification(_ notify: NotificationName) -> Notification {
    return Notification.init(name: NSNotification.Name(rawValue: notify.rawValue))
}

// MARK: - Get NotificationName
func GET_Notification_Name(_ notify: NotificationName ) -> Notification.Name {
    return NSNotification.Name(rawValue: notify.rawValue)
}

