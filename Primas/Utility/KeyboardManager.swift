//
//  KeyboardManager.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/8.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class KeyboardManager: NSObject {
    
    static func enAbleMannager(enAble: Bool = false) {
        let keyboardManager = IQKeyboardManager.sharedManager()
        keyboardManager.enable = enAble
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.toolbarDoneBarButtonItemText = ""
        keyboardManager.shouldShowToolbarPlaceholder = false
        keyboardManager.toolbarTintColor = Rcolor.ed5634()
        keyboardManager.enableAutoToolbar = false
    }
    
    static func enAbleDoneButton(enAble: Bool = false) {
        let keyboardManager = IQKeyboardManager.sharedManager()
        if enAble {
            keyboardManager.toolbarDoneBarButtonItemText = Rstring.confirm_BUTTON.localized()
        } else {
            keyboardManager.toolbarDoneBarButtonItemText = ""
        }
    }
    
    static func enAbleToolBar(enAble: Bool = false) {
        let keyboardManager = IQKeyboardManager.sharedManager()
        keyboardManager.enableAutoToolbar = enAble
    }
}
