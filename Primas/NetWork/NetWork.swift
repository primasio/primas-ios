//
//  NetWork.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/5.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//


import UIKit
import Alamofire

let NetWorkTool = NetWork.shared

enum paramEncode {
    case defaultEncode
    case JSONEncode
}

/// Request sucess closure
typealias ResponseSuccess = (_ data:Any)->()
/// Request error closure
typealias ResponseError = (_ error:Error)->()
/// Request Progress closure
typealias ResponseProgress = (_ pro: CGFloat)->()

class NetWork: NSObject {
    
    static var shared:NetWork = {
        let instance = NetWork();
        return instance;
    }();
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")

    // MARK: - Alamofire basic
    
    /// Create a get request
    ///
    /// - Parameters:
    ///   - url: the request url
    ///   - suc: request success callback
    ///   - err: request error callback
    func requestGetWithUrl(_ url: String ,
                           parameters: [String: Any]? = nil,
                           suc: @escaping ResponseSuccess ,
                           err: @escaping ResponseError) {
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters:
            NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(urlStr,
                          method: .get,
                          parameters: parameters)
            .responseJSON {response in
                switch response.result{
                case .success(let value):
                        suc(value)
                case .failure(let error):
                    err(error)
                }
        }
    }

    /// Create a post request
    ///
    /// - Parameters:
    ///   - url: the post request url
    ///   - param: the request parameters
    ///   - encoding: the request parameters encoding
    ///   - headers: the request headers
    ///   - suc: request success callback
    ///   - err: request error callback
    func requestPostWithUrl(_ url :String ,
                            param :[String: Any]?,
                            encoding: paramEncode = .defaultEncode,
                            headers: HTTPHeaders? = nil,
                            suc :@escaping ResponseSuccess ,
                            err :@escaping ResponseError) {
        let urlStr: String = url.addingPercentEncoding(withAllowedCharacters:
            NSCharacterSet.urlQueryAllowed)!
        
        Alamofire.request(urlStr,
                          method: .post,
                          parameters: param,
                          encoding: customEncode(type: encoding),
                          headers: headers).responseJSON
            { (response) in
            switch response.result{
            case .success(let value):
                suc(value)
            case .failure(let error):
                err(error)
            }
        }
    }

    // MARK: - Network Reachability Observer
    func startNetworkObserver() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable :
                debugPrint("The network is not reachable")
                UIApplication.topViewController()?
                    .hudShow(Rstring.common_network_error.localized())
            case .unknown :
                debugPrint("It is unknown whether the network is reachable")
                UIApplication.topViewController()?
                    .hudShow(Rstring.common_unknow_network.localized())
            case .reachable(.ethernetOrWiFi):
                debugPrint("The network is reachable over the WiFi connection")
            case .reachable(.wwan):
                debugPrint("The network is reachable over the WWAN connection")
            }
        }
        // start listening
        reachabilityManager?.startListening()
    }
    
    func customEncode(type: paramEncode) -> ParameterEncoding {
        switch type {
        case .defaultEncode:
            return URLEncoding.default
        case .JSONEncode:
            return JSONEncoding.default
        }
    }
    
   
}
