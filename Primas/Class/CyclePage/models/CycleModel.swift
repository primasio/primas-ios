//
//  CycleModel.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import HandyJSON
class CycleModel: BaseModel {
    
    var ID: String!
    
    var CreatedAt:String!
    
    var UpdatedAt:String!
    
    var DeletedAt:String!

    var UserAddress: String!
    
    var DNA:String!
    
    var icon: String!
    
    var Title: String!
    
    var Description: String!
    
    var MemberCount = 0 as NSInteger

    var ArticleCount = 0 as NSInteger
    
    var Signature: String!
    
    var Status: String!

    var TxStatus: NSInteger! // 1创建的  2加入的
    
    var follow_state = 0 as NSInteger //关注状态 0未关注  1关注
    
    var join_state = 0 as NSInteger //加入状态 0未加入  1加入

    var update_num = 0 as NSInteger
    
    var IsMember: IsMember?
    
    var worth: Double = Double(arc4random())/1000.0

    var cellHeight: CGFloat! {
        return 100;
    }
    
    var info_string: String!
    
    var GroupArticles: [ArticelModel]!
    
    func get_info_string() -> String {
        if (self.info_string.isEmpty) {
            info_string = "\(MemberCount) \(Rstring.cycle_member.localized())   \(ArticleCount) \(Rstring.cycle_content.localized())"
        }
        return info_string
    }
    
    class func testModel() -> CycleModel {
        let model = CycleModel()
        let radom = NSInteger(arc4random())
        let str = String(radom%10000)
        model.Title = "这个title" + str
        var des = "这只是一个描述" + str
        if radom%4 == 1 {
            des += "\n这只是一个描述" + str
        }
        if radom%4 == 2 {
            des += "\n这只是一个描述" + str + "\n这只是一个描述" + str
        }
        if radom%4 == 3 {
            des += "\n这只是一个描述" + str + "\n这只是一个描述" + str + "\n这只是一个描述" + str
        }

        model.Description = des
        model.MemberCount = radom%999;
        model.ArticleCount = radom%444;
        model.update_num = radom%100;
        
        model.TxStatus = radom%2;
        model.join_state = NSInteger(arc4random())%2
        model.follow_state = NSInteger(arc4random())%2
        model.worth = Double(arc4random())/10000.0
        return model;
    }
    
    
    override func mapping(mapper: HelpingMapper) {
        //*
        mapper <<<
            self.info_string <-- "Signature"
        //*/
    }

}
