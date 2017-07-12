//
//  ValueModel.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ValueModel: NSObject {
  var createdAt: Int
  var awardType: PrimasAwardType
  var award: Double
  var title: String

  init(_ awardType: PrimasAwardType, _ award: Double, _ title: String, _ createdAt: Int) {
    self.createdAt = createdAt
    self.awardType = awardType
    self.award = award
    self.title = title
  }
}
