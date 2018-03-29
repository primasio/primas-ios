//
//  CommentModel.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/3.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit

/*
 article getComment response ---- {
 data = "[{\"ID\":1,\"CreatedAt\":1514966407,\"GroupDNA\":\"224AREKZRLQ344FG3MX2EKILXVWCZY0NI8NRNNDLN8Q6VHZYFF\",\"GroupMemberAddress\":\"0x5566C38CcD9DE42A2a857126b963a0aAE175d515\",\"ArticleDNA\":\"5WJMSTU0UAYXBSKZDVEDB9WWP03PNSSPGKOBYEI0UKIJ81OEPM\",\"Content\":\"tttttt is the \",\"ContentHash\":\"c38dfc58e49ec3062d0bdec321133d8b38afb2b5d882ec1832fa209b113ee23b\",\"Signature\":\"\",\"TxStatus\":2}]";
 success = 1;
 }
 */
class CommentModel: BaseModel {
    var ID: String?
    var CreatedAt: String?
    var GroupDNA: String?
    var GroupMemberAddress: String?
    var ArticleDNA: String?
    var Content: String?
    var ContentHash: String?
    var Signature: String?
    var TxStatus: String?
    
}
