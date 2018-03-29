//
//  ArticelModel.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticelModel: BaseModel {

    /*
     {
     data = "{\"ID\":8,\"CreatedAt\":\"2017-12-23T07:40:01.106819612Z\",\"UpdatedAt\":\"2017-12-23T07:40:01.106819612Z\",\"DeletedAt\":null,\"UserAddress\":\"0x7b205D684869e393A339e6d096b2b0bF4a341447\",\"Title\":\"testTitle\",\"Abstract\":\"testContent\",\"Content\":\"testContent\",\"ContentHash\":\"650d8d709e7806ce79e4dd3de313340a6300a20c8cf71fd430148d4f677be755\",\"BlockHash\":\"0x6618f332c08f32de289036b2affbf65d57689000cdd8c74ff800dbfd7d6df267\",\"DNA\":\"2NN8AN7I07PM2DGV5DJX1Z7DC4AS5DIHXJ3SK6Z3PVZYCJ92U1\",\"License\":\"{}\",\"User\":{\"ID\":0,\"CreatedAt\":\"0001-01-01T00:00:00Z\",\"UpdatedAt\":\"0001-01-01T00:00:00Z\",\"DeletedAt\":null,\"Address\":\"\",\"Name\":\"\",\"Extra\":\"{}\",\"Signature\":\"9dc1e833269116c1c6e037ad40a286565c061d0f1a0518d61299dec88e351d023e59c59120c6326421f255554d47504e29154a1979f17d8a66d19272042e323d01\"},\"Extra\":\"{}\",\"Signature\":\"9dc1e833269116c1c6e037ad40a286565c061d0f1a0518d61299dec88e351d023e59c59120c6326421f255554d47504e29154a1979f17d8a66d19272042e323d01\",\"Status\":\"\",\"TxStatus\":1}";
     success = 1;
     }
     */
    
    var ID:String?
    var CreatedAt:String?
    var UpdatedAt:String?
    var DeletedAt:String?
    var UserAddress:String?
    var Title:String?
    var Abstract:String?
    var Content:String?
    var ContentHash:String?
    var BlockHash:String?
    var DNA:String?
    var License:String?
    var Author:UserModel?
    var Extra:String?
    var Signature:String?
    var Status:String?
    var TxStatus:String?
    var LikeCount:String?
    var CommentCount:String?
    var ShareCount:String?
    var GroupDNA:String?
    var TotalIncentives:String?
    
    
    convenience init(json: JSON) {
        self.init()
        let json = JSON(json.rawString()?.data(using: .utf8) as Any)
        guard !json.isEmpty else { return }
        self.ID = json["ID"].stringValue
        self.CreatedAt = json["CreatedAt"].stringValue
        self.UpdatedAt = json["UpdatedAt"].stringValue
        self.DeletedAt = json["DeletedAt"].stringValue
        self.UserAddress = json["UserAddress"].stringValue
        self.Title = json["Title"].stringValue
        self.Abstract = json["Abstract"].stringValue
        self.Content = json["Content"].stringValue
        self.ContentHash = json["ContentHash"].stringValue
        self.BlockHash = json["BlockHash"].stringValue
        self.DNA = json["DNA"].stringValue
        self.License = json["License"].stringValue
        let userJson = JSON(json["Author"].rawString()?.data(using: .utf8) as Any)
        self.Author = UserModel.init(json: userJson)
        self.Extra = json["Extra"].stringValue
        self.Signature = json["Signature"].stringValue
        self.Status = json["Status"].stringValue
        self.LikeCount = json["LikeCount"].stringValue
        self.CommentCount = json["CommentCount"].stringValue
        self.ShareCount = json["ShareCount"].stringValue
        self.GroupDNA = json["GroupDNA"].stringValue
        self.TxStatus = json["TxStatus"].stringValue
        self.TotalIncentives = json["TotalIncentives"].stringValue
    }
    
}
