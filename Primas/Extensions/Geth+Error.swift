//
//  Geth+Error.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/29.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation


let GETH_PWD_ERROR = "could not decrypt key with given passphrase"
let GETH_INPUT_ERROR = "invalid character"


// MARK: - Formated Geth Error
func GethErrorLog(_ error:Error) -> String {
    if error.localizedDescription == GETH_PWD_ERROR {
        return "PWD_ERROR".localized
    } else if error.localizedDescription.contains(find: GETH_INPUT_ERROR) {
        return "GETH_INPUT_ERROR".localized
    }
    return error.localizedDescription
}

// MARK: - Judge is Password error
func IS_PwdError(_ error:Error) -> Bool {
    return error.localizedDescription == GETH_PWD_ERROR
}
