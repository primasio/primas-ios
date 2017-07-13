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
    return ProfileModel("飞奔的🐟", "https://pic1.zhimg.com/v2-5dbfdbd17c41fd25abcd659849409b64_xl.jpg", 168.365, 120359.26, 5665.856, 236, 36)
  }
}
