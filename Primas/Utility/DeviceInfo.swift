//
//  DeviceInfo.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class DeviceInfo {
    
    // MARK: - Get localizedBundle
    ///
    /// - Returns: Bundle
    class func localizedBundle() -> Bundle {
        let languageCode = DeviceInfo.systemLauguageCode()
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle.init(path: path!)
        return bundle!
    }
    
    // MARK: - Get systemLauguageCode()
    ///
    /// - Returns: Language code
    class func systemLauguageCode() -> String {
        
        let lauguageCode = Storage.appLanguageCode()
        if !lauguageCode.isEmpty { return lauguageCode }
        
        // default English language
        var code  = DEFULT_LANGUAGE_CODE
        let languages:Array<String> = X_UserDefaults.value(forKey: "AppleLanguages") as! Array
        if !languages.isEmpty {
            let currentLanguage = languages[0] as NSString
            let systemCode = currentLanguage.substring(to: 2)
            let plistPath:String = Bundle.main.path(forResource: LANGUAGE_CODE_PLIST, ofType: "plist")!
            let array = NSArray.init(contentsOfFile: plistPath)
            if (array?.contains(systemCode))! { code = systemCode }
        }
            return code
    }
    
    // MARK: - App Main Version
    class func appMainVersion() -> String {
        let infoDictionary = Bundle.main.infoDictionary!
        let appVersion = infoDictionary["CFBundleShortVersionString"]
        return appVersion as! String
    }
    
}

extension UIDevice {
    static func isIphoneX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        return false
    }
    
    static func statusTopOffset() -> CGFloat {
        if isIphoneX() {
            return 44
        }
        return 20
    }
    
    static func navTopOffset() -> CGFloat {
        if isIphoneX() {
            return 88
        }
        return 64
    }
    
    static func navTop() -> CGFloat {
        if isIphoneX() {
            return 24
        }
        return 0
    }
    
    static func bottomOffset() -> CGFloat {
        if isIphoneX() {
            return 46
        }
        return 0
    }
    
    static func tabBarHeight() -> CGFloat {
        if isIphoneX() {
            return 83
        }
        return 49
    }
    
    static func width() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func height() -> CGFloat {
        return UIScreen.main.bounds.height
    }
}
