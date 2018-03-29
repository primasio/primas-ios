//
//  ArticleIncentives.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/6.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit

/*
 {
 data = "{\"ID\":0,\"CreatedAt\":0,\"IncentiveType\":1,\"UserAddress\":\"\",\"ArticleDNA\":\"3M6V94I93IEXKGOLZHZTLPHOTD53P71QNNX90UN6SIRKSKGIZ8\",\"GroupDNA\":\"\",\"Amount\":\"0\",\"Status\":3,\"Score\":\"0\",\"IncentiveArticle\":{\"ID\":0,\"CreatedAt\":0,\"UserAddress\":\"\",\"Title\":\"\",\"Abstract\":\"\",\"Content\":\"\",\"ContentHash\":\"\",\"BlockHash\":\"\",\"DNA\":\"\",\"License\":\"\",\"Extra\":\"\",\"Signature\":\"\",\"Status\":\"\",\"TxStatus\":0,\"LikeCount\":0,\"CommentCount\":0,\"ShareCount\":0,\"Author\":{\"ID\":0,\"CreatedAt\":0,\"Address\":\"\",\"Name\":\"\",\"Extra\":\"\",\"Signature\":\"\",\"Balance\":\"0\",\"TokenBurned\":0,\"UserArticles\":null,\"UserGroups\":null},\"GroupDNA\":\"\"},\"IncentiveGroup\":{\"ID\":0,\"CreatedAt\":0,\"UserAddress\":\"\",\"Title\":\"\",\"Description\":\"\",\"Signature\":\"\",\"DNA\":\"\",\"Status\":\"\",\"TxStatus\":0,\"MemberCount\":0,\"ArticleCount\":0,\"IsMember\":null,\"GroupArticles\":null}}";
 success = 1;
 }
 */

class ArticleIncentives: BaseModel {
    var ID: String?
    var CreatedAt: String?
    var IncentiveType: String?
    var UserAddress: String?
    var ArticleDNA: String?
    var GroupDNA: String?
    var Amount: String?
    var Status: String?
    var Score: String?
    var IncentiveArticle: String?
}
