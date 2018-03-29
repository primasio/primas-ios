//
//  BaseModel.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import HandyJSON //https://github.com/alibaba/HandyJSON

class BaseModel : NSObject, HandyJSON  {
    
    required override init() {}
    
    //必须父类实现方法 子类重写才能起作用
    func mapping(mapper: HelpingMapper) {
        /*
        // specify 'cat_id' field in json map to 'id' property in object
        mapper <<<
            self.id <-- "cat_id"
        
        // specify 'parent' field in json parse as following to 'parent' property in object
        mapper <<<
            self.parent <-- TransformOf<(String, String), String>(fromJSON: { (rawString) -> (String, String)? in
                if let parentNames = rawString?.characters.split(separator: "/").map(String.init) {
                    return (parentNames[0], parentNames[1])
                }
                return nil
            }, toJSON: { (tuple) -> String? in
                if let _tuple = tuple {
                    return "\(_tuple.0)/\(_tuple.1)"
                }
                return nil
            })
        
        // specify 'friend.name' path field in json map to 'friendName' property
        mapper <<<
            self.friendName <-- "friend.name"
        
        //排除指定属性
        mapper >>> self.xxxx
        */
    }
}
