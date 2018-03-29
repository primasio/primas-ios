//
//  OthersAPI.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/9.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import SwiftyJSON

class OthersAPI: NSObject {

    static func submitFeedback(
        email:String,
        feedback:String,
        suc: @escaping NoneBlock,
        err: @escaping ResponseError)  {
        
        let url = "https://server.foundation.tokenup.io/feedback?access_token=tokenup-server"
        
        var params = [String: Any]()
        if !email.isEmpty { params["email"] = email }
        if !feedback.isEmpty { params["feedback"] = feedback }
        
        NetWorkTool.requestPostWithUrl(
            url,
            param: params,
            suc: { (res) in
                let response = JSON(res)
                if response["status"].dictionary!["code"] == 200 {
                    suc()
                } else {
                    let message = "submit Feedback error"
                    let domain = "io.primas.submitFeedback.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }, err: err)
    }
}
