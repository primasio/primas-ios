//
//  UserDefaults.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

let PRIMAS_APP_LANGUAGE = "PRIMAS_APP_LANGUAGE"

class Storage {
    
    // MARK: - Storage app language Code
    static func cacheAppLanguageCode(_ code: String) {
        X_UserDefaults.setValue(code, forKey: PRIMAS_APP_LANGUAGE)
        X_UserDefaults.synchronize()
    }
    static func appLanguageCode() -> String {
        let result = X_UserDefaults.value(forKey: PRIMAS_APP_LANGUAGE)
        if result == nil { return "" }
        return result as! String
    }

}
