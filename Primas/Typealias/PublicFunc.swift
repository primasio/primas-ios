//
//  PublicFunc.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/12/11.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation

// MARK: - debug print
public func debugPrint(_ item: Any) {
    #if DEBUG
        print(item)
    #else
        
    #endif
}

public enum Password_Level {
    case high_level
    case middel_level
    case weak_level
}

public func Have_User() -> Bool {
    return UserTool.shared.haveUser()
}

// MARK: -  Judege password level
public func judgePwdLevel(pwd:String) -> Password_Level{
    // 支持数字、字母、符号必须包含其中至少两种
    let pre1 = NSPredicate.init(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).*$")
    // 密码中必须包含大写、小写、数字、字符 要满足3 个
    let pre2 = NSPredicate.init(format: "SELF MATCHES %@", "^(?![0-9a-z]+$)(?![0-9A-Z]+$)(?![0-9\\W]+$)(?![a-z\\W]+$)(?![a-zA-Z]+$)(?![A-Z\\W]+$)[a-zA-Z0-9\\W_]+$")
    
    if pre2.evaluate(with: pwd) {
        // debugPrint("强")
        return .high_level
    } else if pre1.evaluate(with: pwd) {
        // debugPrint("中")
        return .middel_level
    } else {
        return .weak_level
        // debugPrint("弱")
    }
}
