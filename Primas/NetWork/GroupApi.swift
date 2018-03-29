//
//  GroupApi.swift
//  Primas
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class GroupApi: NSObject {

    //创建社群
    static func createGroup(
        passphrase:String,
        title: String,
        des: String,
        suc :@escaping ((_ cycle: CycleModel) -> ()),
        err :@escaping ResponseError)  {
    
        let signString = title + des
        
        SignatureTool.signHash(str: signString, passphrase: passphrase, handle: { (sign) in

            let url = PRIMAS_SERVER + create_group
            let address = UserTool.shared.userAddress()

            assert(!title.isEmpty, "title is empty")
            assert(!address.isEmpty, "address is empty")
            assert(!des.isEmpty, "des is empty")

            var params = [String : Any]()
            
            params["Title"] = title
            params["Description"] = des
            params["UserAddress"] = address
            params["Signature"] = sign
            
            NetWorkTool.requestPostWithUrl(url, param: params, suc: { (response) in
                debugPrint("createGroup ----- \(response)")
                //let result = JSON(response)
                let res = ResponseModel.deserialize(from: response as? [String: Any])
                if res?.success == true {
                    let cycleData = CycleModel.deserialize(from: res?.data)
                    suc(cycleData!)
                } else {
                    let message = res?.message ?? "unknow"
                    let domain = "io.primas.ArticleAPI.getArticleMetadata.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: { (error) in
                err(error)
                debugPrint(error)
            })
        }) { (error) in
            err(error)
        }
    }
    
    //加入社群
    static func joinGroup(
        passphrase:String,
        dna: String,//社群dna
        suc :@escaping ((_ res: CycleModel) -> ()),
        err :@escaping ResponseError)  {
        
        let signString = dna
        SignatureTool.signHash(str: signString, passphrase: passphrase, handle: { (sign) in
            
            assert(!dna.isEmpty, "dna is empty")
            
            
            let url = PRIMAS_SERVER + String.init(format: join_group, dna)
            
            var params = [String : Any]()
            params["Signature"] = sign
            
            let address = UserTool.shared.userAddress()
            params["MemberAddress"] = address
            
            NetWorkTool.requestPostWithUrl(url, param: params, suc: { (response) in
                debugPrint("joinGroupMetadata ----- \(response)")
                //let result = JSON(response)
                let res = ResponseModel.deserialize(from: response as? [String: Any])
                if res?.success == true {
                    let model = CycleModel.deserialize(from: res?.data)!
                    suc(model)
                } else {
                    let message = res?.message ?? "unknow"
                    let domain = "io.primas.GroupAPI.joinGroup.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: { (error) in
                err(error)
                debugPrint(error)
            })
        }) { (error) in
            err(error)
        }
    }
    
    //退出社群
    static func exitGroup(
        passphrase:String,
        dna: String,//社群dna
        suc :@escaping ((_ res: CycleModel) -> ()),
        err :@escaping ResponseError)  {
        
        let signString = dna
        SignatureTool.signHash(str: signString, passphrase: passphrase, handle: { (sign) in
            
            assert(!dna.isEmpty, "dna is empty")
            
            let url = PRIMAS_SERVER + String.init(format: exit_group, dna)
            
            let address = UserTool.shared.userAddress()
            var params = [String : Any]()
            params["Signature"] = sign
            params["MemberAddress"] = address
            
            NetWorkTool.requestPostWithUrl(url, param: params, suc: { (response) in
                debugPrint("exitGroupMetadata ----- \(response)")
                //let result = JSON(response)
                let res = ResponseModel.deserialize(from: response as? [String: Any])
                if res?.success == true {
                    let model = CycleModel.deserialize(from: res?.data)!
                    suc(model)
                } else {
                    let message = res?.message ?? "unknow"
                    let domain = "io.primas.GroupAPI.exitGroup.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: { (error) in
                err(error)
                debugPrint(error)
            })
        }) { (error) in
            err(error)
        }
    }
    
    //移除社群成员
    static func removeGroup(
        passphrase:String,
        dna: String,//社群dna
        suc :@escaping ((_ res: ResponseModel) -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        let signString = dna+address
        SignatureTool.signHash(str: signString, passphrase: passphrase, handle: { (sign) in
            
            assert(!dna.isEmpty, "dna is empty")
            
            let url = PRIMAS_SERVER + String.init(format: remove_group, dna)
            
            var params = [String : Any]()
            params["Signature"] = sign
            params["MemberAddress"] = address
            
            NetWorkTool.requestPostWithUrl(url, param: params, suc: { (response) in
                debugPrint("removeGroup ----- \(response)")
                //let result = JSON(response)
                let res = ResponseModel.deserialize(from: response as? [String: Any])
                if res?.success == true {
                    suc(res!)
                } else {
                    let message = res?.message ?? "unknow"
                    let domain = "io.primas.GroupAPI.removeGroup.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: { (error) in
                err(error)
                debugPrint(error)
            })
        }) { (error) in
            err(error)
        }
    }
    
    
    //加入小组列表
    static func joinedGroups(
        Start: String,
        Offset:String? = nil,
        suc :@escaping ((_ res: [CycleModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + create_group
        
        let address = UserTool.shared.userAddress()
        var params = ["address": address]
        params["start"] = Start
        params["offset"] = Offset
        
        NetWorkTool.requestGetWithUrl(url, parameters: params,
                                      suc: { (response) in
            debugPrint("joinedGroups ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let arr = [CycleModel].deserialize(from: res?.data) as! [CycleModel]
                suc(arr)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.GroupAPI.joinedGroups.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    
    //发现圈子
    static func discoverGroups(
        suc :@escaping ((_ res: [CycleModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + discover_group

        NetWorkTool.requestGetWithUrl(url, parameters: nil, suc: { (response) in
            
            debugPrint("discoverGroups ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let arr = [CycleModel].deserialize(from: res?.data) as! [CycleModel]
                suc(arr)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.GroupAPI.discoverGroups.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    //关注的圈子
    static func followGroups(
        Start: String,
        Offset:String? = nil,
        suc :@escaping ((_ res: [CycleModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + follow_group
        
        let address = UserTool.shared.userAddress()
        var params = ["address": address]
        params["Start"] = Start
        params["Offset"] = Offset
        
        NetWorkTool.requestGetWithUrl(url, parameters: params, suc: { (response) in
            
            debugPrint("followGroups ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let arr = [CycleModel].deserialize(from: res?.data) as! [CycleModel]
                suc(arr)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.GroupAPI.followGroups.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    // 用户自己的圈子
    static func userGroups(
        Start: String!,
        Address:String!,
        Offset:Int = request_start_offset,
        suc :@escaping ((_ res: [CycleModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let address = Address ?? UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        
        let url = PRIMAS_SERVER +  String.init(format: get_user_groups, address)
        var params = ["offset" : String(Offset)]
        params["Start"] = Start
        NetWorkTool.requestGetWithUrl(url, parameters: params, suc: { (response) in
            
            debugPrint("userGroups ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let arr = [CycleModel].deserialize(from: res?.data) as! [CycleModel]
                suc(arr)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.GroupAPI.userGroups.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    //群组信息
    static func groupInfo(
        dna: String, //社群dna
        suc :@escaping ((_ res: CycleModel) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + String.init(format: groups_info, dna)
        
        var paras: [String: Any] = [:]
        let address = UserTool.shared.userAddress()
        if !address.isEmpty { paras["address"] = address }
        
        NetWorkTool.requestGetWithUrl(url, parameters: paras, suc: { (response) in
            debugPrint("groupInfo Response ----- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let model = CycleModel.deserialize(from: res?.data) as CycleModel!
                suc(model!)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.GroupAPI.groupInfo.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    //文章列表
    static func groupArticles(
        dna: String, //社群dna
        UserAddress: String!, //某个用户
        Start: String,
        Offset:String,
        suc :@escaping ((_ res: [ArticelModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + String.init(format: groups_articles, dna)
        var params = ["start": Start]
        params["offset"] = Offset
        params["userAddress"] = UserAddress
        
        NetWorkTool.requestGetWithUrl(url, parameters: params, suc: { (response) in
            debugPrint("groupArticles Response ----- \(response)")
            let result = JSON(response)
            if result["success"].boolValue == true {
                let array = JSON(result["data"].rawString()?.data(using: .utf8) as Any).array
                var results = [ArticelModel]()
                for json in array! {
                    let articelData = ArticelModel.init(json: json)
                    results.append(articelData)
                }
                suc(results)
            } else {
                let message = result["message"].isEmpty ? "unkonw" : result["message"].stringValue
                let domain = "io.primas.GroupAPI.groupArticles.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    
    //用户文章列表
    static func userGroupArticles(
        dna: String, //社群dna
        UserAddress: String!, //某个用户
        Offset:String,
        suc :@escaping ((_ res: [ArticelModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let url = PRIMAS_SERVER + String.init(format: user_groups_articles, UserAddress, dna)
        let params = ["offset" :  Offset]
        NetWorkTool.requestGetWithUrl(url, parameters: params, suc: { (response) in
            debugPrint("userGroupArticles Response ----- \(response)")
            let result = JSON(response)
            if result["success"].boolValue == true {
                let array = JSON(result["data"].rawString()?.data(using: .utf8) as Any).array
                var results = [ArticelModel]()
                for json in array! {
                    let articelData = ArticelModel.init(json: json)
                    results.append(articelData)
                }
                suc(results)
            } else {
                let message = result["message"].isEmpty ? "unkonw" : result["message"].stringValue
                let domain = "io.primas.GroupAPI.userGroupArticles.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
}
