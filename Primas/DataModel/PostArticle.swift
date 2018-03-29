//
//  PostArticle.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class PostArticle: NSObject {

    var title = ""
    var content = ""
    lazy var tags: [String] = {
        return []
    }()
    
    static let shared = PostArticle.init()
    private override init(){}
    
    
    /// add tags
    func addTags(tag: String)  {
            if tags.contains(tag) {
                tags.remove(at: tags.index(of: tag)!)
            } else {
                tags.append(tag)
            }
    }
    
    
    /// reset data
    func resetDat() {
        title = ""
        content = ""
        tags.removeAll()
    }
}
