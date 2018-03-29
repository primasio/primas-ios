//
//  String+Localized.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import Rswift

extension StringResource {
    
    public func localized() -> String {
        let code = DeviceInfo.systemLauguageCode()
        return localized(code)
    }
    
    
    fileprivate func localized(_ language: String) -> String {
        guard
            let basePath = bundle.path(forResource: DEFULT_LANGUAGE_CODE, ofType: "lproj"),
            let baseBundle = Bundle(path: basePath)
            else {
                return self.key
        }
        
        let fallback = baseBundle.localizedString(forKey: key, value: key, table: tableName)
        
        guard
            let localizedPath = bundle.path(forResource: language, ofType: "lproj"),
            let localizedBundle = Bundle(path: localizedPath)
            else {
                return fallback
        }
        
        return localizedBundle.localizedString(forKey: key, value: fallback, table: tableName)
    }
}
