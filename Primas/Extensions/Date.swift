//
//  Date.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation

extension Date {
    
    // Get timeStamp
    static func timeStamp() -> String {
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = "\(timeInterval)"
        return timeStamp
    }
    
}
