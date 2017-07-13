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

  static func generateTestData() -> [Array<ValueModel>] {
    var data: [ValueModel] = []

    data.append(ValueModel(.transfer, 10.0, "柯文哲明确回应「两岸一家亲」", 1499846387))
    data.append(ValueModel(.share, 10, "郎平亦没辙！中国女排面对苦主噩梦续集", 1499846387))
    data.append(ValueModel(.praise, 265, "马云首家无人超市落户杭州 微博出现十", 1499846387))
    data.append(ValueModel(.origin, 23, "宋楚瑜不满台军退役将领赴路：部队还没有", 1499846387))
    data.append(ValueModel(.praise, 654, "免考入学通道将于7月12日关闭", 1499846387))
    data.append(ValueModel(.share, 654, "免考入学通道将于7月12日关闭", 1499846387))
    
    var arr: [Array<ValueModel>] = []
    arr.append(data)
    arr.append(data)
    return arr
  }
}
