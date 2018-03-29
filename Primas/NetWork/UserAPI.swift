//
//  UserAPI.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserAPI: NSObject {
    
    // MARK: - update user name
    static func updateUserName(
        name: String,
        passphrase:String,
        extra:String = "{}",
        suc :@escaping ((_ user: UserModel)->()),
        err :@escaping ResponseError)
    {
        let address = UserTool.shared.userAddress()

        assert(!name.isEmpty, "name.isEmpty")
        assert(!passphrase.isEmpty, "passphrase.isEmpty")
        assert(!address.isEmpty, "address.isEmpty")

        // Signature
        let signString = name + extra
        SignatureTool.signHash(str: signString,  passphrase: passphrase, handle: { (sign) in
            
                let url = PRIMAS_SERVER + update_UserInfo
                var params = [String : Any]()
                params["Name"] = name
                params["Signature"] = sign
                params["Extra"] = extra
                params["Address"] = address
            
                NetWorkTool.requestPostWithUrl(url, param: params,  suc: { (response) in
                        debugPrint(UserTool.shared.userAddress())
                        debugPrint("updateInfo response ---- \(response)")
                        let result = JSON(response)
                        if result["success"].boolValue == true {
                            let modelData = result["data"]
                            let userModel = UserModel.init(json: modelData)
                            suc(userModel)
                        } else {
                            let message = result["message"].stringValue
                            let domain = "io.primas.UserAPI.updateInfo.error"
                            let userInfo = [NSLocalizedDescriptionKey : message]
                            let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                            err(error)
                        }
                }, err: err)
        }) { (error) in
            err(error)
        }
    }
    
    // success
    /*
     {
     "data": {
     "ID": 1,
     "CreatedAt": "2017-12-20T15:47:19.1148618+08:00",
     "UpdatedAt": "2017-12-20T15:47:19.1158644+08:00",
     "DeletedAt": null,
     "Address": "0xC05d73eb72b45a5ae3F13a7e3DEE67830165cFf4",
     "Name": "Updated",
     "Extra": "{}",
     "Signature": "11a96b8b68231da72f824d0c58476bb7e657a0f4dfd6e693cbe85
     c6628b1cbe8650457c6059817e91ebfae470e69df4eaf3cf63f89311f013a6f42b78c3e320901"
     },
     "success": true
     }
     */
    //error
    /*
    {
     message = " ";
     success = 0;
     }
   */
    
    // MARK: - Get user info
    static func getUserInfo(
        Address: String!,
        suc :@escaping ((_ user: UserModel)->()),
        err :@escaping ResponseError)  {
        
        let addrss = Address ?? UserTool.shared.userAddress()
        assert(!addrss.isEmpty, "addrss is empty")
        let url = PRIMAS_SERVER + update_UserInfo + "/" + addrss
        NetWorkTool.requestGetWithUrl(url, suc: { (response) in
            debugPrint("getUserInfo ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            let result = JSON(response)
            if res?.success == true {
                //let modelData = result["data"]
                let userModel = UserModel.deserialize(from: res?.data)!
                suc(userModel)
            } else {
                let message = result["message"].stringValue
                let domain = "io.primas.UserAPI.getUserInfo.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    
}
