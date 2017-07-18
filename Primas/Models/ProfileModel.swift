//
//  ProfileModel.swift
//  Primas
//
//  Created by wang on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ProfileModel: NSObject {
  var username: String
  var userImageUrl: String
  var profileIndex: Double
  var hp: Double
  var pst: Double
  var contentCount: Int
  var group: Int

  init(_ username: String, _ userImageUrl: String, _ profileIndex: Double, _ hp: Double, _ pst: Double, _ contentCount: Int, _ group: Int) {
    self.username = username
    self.userImageUrl = userImageUrl
    self.profileIndex = profileIndex
    self.hp = hp
    self.pst = pst
    self.contentCount = contentCount
    self.group = group
  }

  static func generateTestData() -> ProfileModel {
    let user = app().client.data!["user"] as! [String: Any]
    let username = user["nickname"] as! String
    let userImage = user["avatar"] as! String
    let profileIndex = user["credit"] as! Double
    let hp = user["hp"] as! Double
    let pst = user["balance"] as! Double
    let articles = user["articles"] as! [String: Any]
    let contentCount = articles["total"] as! Int
    let baseUrl = app().client.baseURL
    let group = user["groups"] as! [String: Any]
    let groupCount = group["total"] as! Int
    
    return ProfileModel(username, baseUrl + userImage, profileIndex, hp, pst, contentCount, groupCount)
  }
}
