//
//  ValueTopModel.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ValueTopModel: NSObject {
  var title: String
  var award: Double
  var praised: Int
  var transfered: Int
  var shared: Int

  init(_ title: String, _ award: Double, _ praised: Int, _ transfered: Int, _ shared: Int) {
    self.title = title
    self.award = award
    self.praised = praised
    self.transfered = transfered
    self.shared = shared
  }

  static func generateTestData() -> [ValueTopModel] {
    var data: [ValueTopModel] = []

    data.append(ValueTopModel( "柯文哲明确回应「两岸一家亲」", 6356.0, 36, 2699, 3333))
    data.append(ValueTopModel("郎平亦没辙！中国女排面对苦主噩梦续集", 224.5, 23, 122, 11331))
    data.append(ValueTopModel("马云首家无人超市落户杭州 微博出现十", 299.99, 23, 222, 11231))
    data.append(ValueTopModel("宋楚瑜不满台军退役将领赴路：部队还没有", 111, 122, 12341, 123412))
    data.append(ValueTopModel("免考入学通道将于7月12日关闭", 111.11, 11234, 1112341, 1122))
    data.append(ValueTopModel("免考入学通道将于7月12日关闭", 11.1, 1123, 1123, 123412))
    data.append(ValueTopModel( "柯文哲明确回应「两岸一家亲」", 6356, 36, 2699, 3333))
    data.append(ValueTopModel("郎平亦没辙！中国女排面对苦主噩梦续集", 224.5, 23, 122, 11331))
    data.append(ValueTopModel("马云首家无人超市落户杭州 微博出现十", 299.99, 23, 222, 11231))
    data.append(ValueTopModel("宋楚瑜不满台军退役将领赴路：部队还没有", 111, 122, 12341, 123412))
    data.append(ValueTopModel("免考入学通道将于7月12日关闭", 111.11, 11234, 1112341, 1122))
    data.append(ValueTopModel("免考入学通道将于7月12日关闭", 11.1, 1123, 1123, 123412))

    return data
  }
}
