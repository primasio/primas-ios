//
//  WorthModel.swift
//  Primas
//
//  Created by figs on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class WorthModel: BaseModel {
    
    var worth_num: Double!
    
    var available_num: NSInteger!
    
    var block_num: NSInteger!
    
    var hisroty_num: Double!
    
    
    var yesterday_num: NSInteger!
    
    class func testModel() -> WorthModel {
        let model = WorthModel()
        let radom = NSInteger(arc4random())
        model.worth_num = Double(arc4random())/1000.0
        model.available_num = radom%999;
        model.block_num = radom%100;
        model.yesterday_num = model.block_num - radom%77
        model.hisroty_num = Double(arc4random())/1000.0;
        return model;
    }
}

class WorthRecord: BaseModel {
    var title: String!
    var worth_num: String!
    var time: String!
    var type: String!

}

