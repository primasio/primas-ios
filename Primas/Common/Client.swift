//
//  Client.swift
//  Primas
//
//  Created by wang on 17/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import Networking
import Foundation

class Client {
  init () {
    let networking = Networking(baseURL: "http://yb-public.oss-cn-shanghai.aliyuncs.com/primas_data/")
    networking.get("primas.json") {
      result in 
         switch result {
          case .success(let response):
              // We know we'll be receiving an array with the best recipes, so we can just do:
              let recipes = response.arrayBody // BOOM, no optionals. [[String: Any]]

              // If we need headers or response status code we can use the HTTPURLResponse for this.
              let headers = response.headers // [String: Any]
          case .failure(let response):
              // Non-optional error ✨
              let errorCode = response.error.code

              // Our backend developer told us that they will send a json with some
              // additional information on why the request failed, this will be a dictionary.
              let json = response.dictionaryBody // BOOM, no optionals here [String: Any]

              // We want to know the headers of the failed response.
              let headers = response.headers // [String: Any]

              print("xxxxxxxxxxxxx: \(errorCode) \(json) \(headers)")
          }
    }
  }
}
