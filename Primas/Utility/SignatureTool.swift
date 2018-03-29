//
//  SignatureTool.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import ethers
import Geth

class SignatureTool: NSObject {

    // MARK: - Signature hash
    static func signHash(str: String,
                  passphrase:String,
                  handle: @escaping (_ signString:String) -> (),
                  err: @escaping errorBlock)  {
        
        guard UserTool.shared.haveUser() else { return }
        guard !str.isEmpty else { return }
        guard !passphrase.isEmpty else { return }

        // sha-3 256 hash
        let secureData = SecureData.init(data: str.toData())
        let hashString  = secureData?.keccak256().hexString()
        let data = SecureData.init(hexString: hashString).data()
        let account = UserTool.shared.userAccount()
        
        GethTool.signHashData(
            account: account,
            passphrase: passphrase,
            hashData: data!,
            handle: { (d) in
                let sign = SecureData.data(toHexString: d)
                handle(sign!.remove0xPrefix())
        }) { (error) in
            err(error)
        }
    }
}
