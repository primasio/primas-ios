//
//  IsMember.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/4.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import HandyJSON

class IsMember: BaseModel {

    /*
     {\"ID\":21,\"CreatedAt\":1515049307,\"GroupDNA\":\"21I6QIJ0KFYUATFKAZCPTIZW44WL1B8BRK1XZAOQPMUMVCFMSY\",\"MemberAddress\":\"0x5566C38CcD9DE42A2a857126b963a0aAE175d515\",\"Signature\":\"\",\"TxStatus\":2},\"GroupArticles\":[]}
     */
    
    var ID: String?
    var CreatedAt:String?
    var GroupDNA:String?
    var MemberAddress:String?
    var Signature:String?
    var TxStatus:String?
    var GroupArticles:String?
    
}
