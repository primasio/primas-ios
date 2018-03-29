//
//  String+Hash.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import ethers

extension String {
    
    var keccak256Hash:String {
        assert(!self.isEmpty, "emprty string")
        let secureData = SecureData.init(data: self.toData())
        let hashString  = secureData?.keccak256().hexString().remove0xPrefix()
        return hashString!
    }
    
}
