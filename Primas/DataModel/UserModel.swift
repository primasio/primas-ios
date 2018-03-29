//
//  UserModel.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import SwiftyJSON

/*
 {
 "data": {
 "ID": 1,
 "CreatedAt": "2017-12-20T15:47:19.1148618+08:00",
 "UpdatedAt": "2017-12-20T15:47:19.1158644+08:00",
 "DeletedAt": null,
 "Address": "0xC05d73eb72b45a5ae3F13a7e3DEE67830165cFf4",
 "Name": "Updated",
 "Extra": "{}",
 "Signature": "11a96b8b68231da72f824d0c58476bb7e657a0f4dfd6e693cbe85
 c6628b1cbe8650457c6059817e91ebfae470e69df4eaf3cf63f89311f013a6f42b78c3e320901"
 },
 "success": true
 }
 */

class UserModel: BaseModel {
    
    var ID:String?
    var CreatedAt:String?
    var UpdatedAt:String?
    var DeletedAt:String?
    var Address:String?
    var Name:String?
    var Extra:String?
    var Signature:String?
    var TokenBurned:String?
    
    var Balance: String?
    var GroupCount = 0 as NSInteger
    var ArticleCount = 0 as NSInteger
    var UserArticles: [ArticelModel]!
    var UserGroups: [CycleModel]!
    
    convenience init(json: JSON) {
        self.init()
        let json = JSON(json.rawString()?.data(using: .utf8) as Any)
        guard !json.isEmpty else { return }
        
        self.ID = json["ID"].stringValue
        self.CreatedAt = json["CreatedAt"].stringValue
        self.UpdatedAt = json["UpdatedAt"].stringValue
        self.DeletedAt = json["DeletedAt"].stringValue
        self.Address = json["Address"].stringValue
        self.Name = json["Name"].stringValue
        self.Signature = json["Signature"].stringValue
        self.TokenBurned = json["TokenBurned"].stringValue
    }
    
    static func testModel() -> UserModel {
        let user = UserModel()
        user.Name = "user 001"
        user.Signature = "简介 00111"
        return user
    }
}
