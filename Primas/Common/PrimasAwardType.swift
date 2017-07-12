//
//  PrimasAwardType.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

public enum PrimasAwardType: Int {
  case praise, share, transfer, origin
}

func getPrimasAwardBackgroundColor(_ type: PrimasAwardType) -> UIColor {
  switch type {
    case .praise:
      return hexStringToUIColor("#ffa79c")
    case .share:
      return hexStringToUIColor("#86c5f1")
    case .transfer:
      return hexStringToUIColor("#d6b1e8")
    case .origin:
      return hexStringToUIColor("#86e0b7")
  }
}

let PrimasAwardTypeDictionary: [PrimasAwardType: String] = [
  .praise: "点赞", .share: "转发", .transfer: "转载", .origin: "原创"
]