//
//  ArticleDetailModel.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import Foundation

class ArticleDetailModel {
    var title: String
    var content: String

    var username: String
    var userImageUrl: String

    var createdAt: Int

    var shared: Int
    var transfered: Int
    var stared: Int
    var DNA: String

    init(_ title: String, _ content: String, _ username: String, _ userImageUrl: String, _ createdAt: Int, _ shared: Int, _ transfered: Int, _ stared: Int, _ DNA: String ) {
      self.title = title
      self.content = content
      self.username = username
      self.userImageUrl = userImageUrl
      self.createdAt = createdAt
      self.shared = shared
      self.transfered = transfered
      self.stared = stared
      self.DNA = DNA
    }

    static func generateTestData() -> ArticleDetailModel {
      return ArticleDetailModel("一千元人民币在越南可以花多久？",
        "按照当前汇率一元人民币可以兑换3333.333越南币,看来一元人民币在越南很多.似乎可以在越南生活的很幸福？",
        "胡适", "https://img3.doubanio.com/icon/u36356293-3.jpg", 1499747389, 2800, 39999, 66666
        , "ZHDSLA")
    }
}
