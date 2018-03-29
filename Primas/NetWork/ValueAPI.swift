//
//  ValueAPI.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/5.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ValueAPI: NSObject {

    // MARK: - Get HP
    static func getHP(
        suc :@escaping ((_ content: String) -> ()),
        err :@escaping ResponseError)  {
    
    let address = UserTool.shared.userAddress()
    assert(!address.isEmpty, "address.isEmpty")
    
    let url = PRIMAS_SERVER + String.init(format: get_hp_value, address)
    
    NetWorkTool.requestGetWithUrl(
        url,
        suc: { (response) in
          debugPrint("getHP  response ---- \(response)")
            let result = JSON(response)
            if result["success"].boolValue == true {
                let data = result["data"].stringValue
                var result = String(data.dropLast())
                result = String(result.dropFirst())
                suc(result)
            } else {
                let message = result["message"].stringValue == "" ? "unkonw" : result["message"].stringValue
                let domain = "io.primas.ValueAPI.getHP.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
    }, err: err)
    
    }
    
    // MARK: - Get balance value
    static func getBalance(
        suc :@escaping ((_ content: String) -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        
        let url = PRIMAS_SERVER + String.init(format: get_balance_value, address)
        
        NetWorkTool.requestGetWithUrl(
            url,
            suc: { (res) in
                debugPrint("getBalance  response ---- \(res)")
                let result = JSON(res)
                if result["success"].boolValue == true {
                    let data = result["data"].stringValue
                    var result = String(data.dropLast())
                    result = String(result.dropFirst())
                    suc(result.toPstValue())
                } else {
                    let message = result["message"].stringValue == "" ? "unkonw" : result["message"].stringValue
                    let domain = "io.primas.ValueAPI.getBalance.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }, err: err)
        
    }
    
    // MARK: - Get balance locked
    static func getBalanceLocked(
        suc :@escaping ((_ content: String) -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        
        let url = PRIMAS_SERVER + String.init(format: get_balance_locked, address)
        
        NetWorkTool.requestGetWithUrl(
            url,
            suc: { (res) in
                debugPrint("getBalanceLocked  response ---- \(res)")
                let result = JSON(res)
                if result["success"].boolValue == true {
                    let data = result["data"].stringValue
                    var result = String(data.dropLast())
                    result = String(result.dropFirst())
                    suc(result.toPstValue())
                } else {
                    let message = result["message"].stringValue == "" ? "unkonw" : result["message"].stringValue
                    let domain = "io.primas.ValueAPI.getBalance.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }, err: err)
        
    }
    
    // MARK: - User Burn
    static func burn(
        suc :@escaping (() -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        
        let url = PRIMAS_SERVER +  String.init(format: gert_user_burn, address)
        
        NetWorkTool.requestPostWithUrl(
            url,
            param: nil,
            suc: { (res) in
                debugPrint("user burn  response ---- \(res)")
        }, err: err)
        
    }
    
    // MARK: - Get incentives
    static func incentives(
        address: String,
        Start: String,
        Offset:Int,
        suc :@escaping ((_ models: [WorthRecord]) -> ()),
        err :@escaping ResponseError)  {
        
        assert(!address.isEmpty, "address.isEmpty")
        let param = ["address" : address, "offset" : String(Offset), "start" : Start]
        let url = PRIMAS_SERVER + get_incentives
        NetWorkTool.requestGetWithUrl(
            url,
            parameters: param,
            suc: { (res) in
                debugPrint("get incentives  response ---- \(res)")
                let result = JSON(res)
                if result["success"].boolValue == true {
                    var models: [WorthRecord] = []
                    let jsonData = JSON(result["data"].rawString()?.data(using: .utf8) as Any)
                    let data = jsonData.array
                    for j in data! {
                        let json = JSON(j.rawString()?.data(using: .utf8) as Any)
                        let IncentiveType = json["IncentiveType"].stringValue

                        if IncentiveType != "2"  {
                            let model = WorthRecord.init()
                            model.type = IncentiveType
                            model.time = json["CreatedAt"].stringValue.toTimeString()
                            model.worth_num = json["Amount"].stringValue.toPstValue()
                            let IncentiveArticle = JSON(json["IncentiveArticle"].rawString()?.data(using: .utf8) as Any)
                            model.title = IncentiveArticle["Title"].stringValue
                            models.append(model)
                        }
                    }
                    
                    suc(models)
                } else {
                    let message = result["message"].stringValue == "" ? "unkonw" : result["message"].stringValue
                    let domain = "io.primas.ValueAPI.getHP.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }, err: err)
        
    }
}
