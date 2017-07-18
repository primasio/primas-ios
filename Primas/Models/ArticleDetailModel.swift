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

    init(title: String, content: String, username: String, userImageUrl: String, createdAt: Int, shared: Int, transfered: Int,  stared: Int, DNA: String ) {
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
}
