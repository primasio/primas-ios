//
//  ArticleAPI.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import SwiftyJSON
import ethers

class ArticleAPI: NSObject {

    /*
    {
    data = "{\"ID\":8,\"CreatedAt\":\"2017-12-23T07:40:01.106819612Z\",\"UpdatedAt\":\"2017-12-23T07:40:01.106819612Z\",\"DeletedAt\":null,\"UserAddress\":\"0x7b205D684869e393A339e6d096b2b0bF4a341447\",\"Title\":\"testTitle\",\"Abstract\":\"testContent\",\"Content\":\"testContent\",\"ContentHash\":\"650d8d709e7806ce79e4dd3de313340a6300a20c8cf71fd430148d4f677be755\",\"BlockHash\":\"0x6618f332c08f32de289036b2affbf65d57689000cdd8c74ff800dbfd7d6df267\",\"DNA\":\"2NN8AN7I07PM2DGV5DJX1Z7DC4AS5DIHXJ3SK6Z3PVZYCJ92U1\",\"License\":\"{}\",\"User\":{\"ID\":0,\"CreatedAt\":\"0001-01-01T00:00:00Z\",\"UpdatedAt\":\"0001-01-01T00:00:00Z\",\"DeletedAt\":null,\"Address\":\"\",\"Name\":\"\",\"Extra\":\"{}\",\"Signature\":\"9dc1e833269116c1c6e037ad40a286565c061d0f1a0518d61299dec88e351d023e59c59120c6326421f255554d47504e29154a1979f17d8a66d19272042e323d01\"},\"Extra\":\"{}\",\"Signature\":\"9dc1e833269116c1c6e037ad40a286565c061d0f1a0518d61299dec88e351d023e59c59120c6326421f255554d47504e29154a1979f17d8a66d19272042e323d01\",\"Status\":\"\",\"TxStatus\":1}";
    success = 1;
    }
    */
    
    // MARK: - Post article
     static func postArticle(
        passphrase:String,
        title:String,
        content:String,
        license: String,
        extra: String,
        suc :@escaping ((_ article: ArticelModel) -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        
        assert(!passphrase.isEmpty, "passphrase.isEmpty")
        assert(!address.isEmpty, "address.isEmpty")
        assert(!title.isEmpty, "title")
        assert(!content.isEmpty, "content.isEmpty")

        // Signature

        let signString = title + content.keccak256Hash + license
        
        SignatureTool.signHash(str: signString,  passphrase: passphrase, handle: { (sign) in
            
            let url = PRIMAS_SERVER + post_Article
            var params = [String : Any]()
            params["Title"] = title
            params["Content"] = content
            params["License"] = license
            params["Signature"] = sign
            params["Extra"] = extra
            params["UserAddress"] = address
            
            NetWorkTool.requestPostWithUrl(url, param: params,  suc: { (response) in
                debugPrint(UserTool.shared.userAddress())
                debugPrint("postArticle response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    let articelData = ArticelModel.init(json: result["data"])
                    suc(articelData)
                } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.GroupAPI.creatGroup.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: err)
        }) { (error) in
            err(error)
        }
    }
    
    // MARK: - Get Article Metadata
    static func getArticleMetadata(
        dna: String,
        suc :@escaping ((_ article: ArticelModel) -> ()),
        err :@escaping ResponseError)  {
        
        assert(!dna.isEmpty, "dna is empty")

        let url = PRIMAS_SERVER + post_Article + "/" + dna
        NetWorkTool.requestGetWithUrl(url, suc: { (response) in
            debugPrint("getArticleMetadata ----- \(response)")
            let result = JSON(response)
            if result["success"].boolValue == true {
                let articelData = ArticelModel.init(json: result["data"])
                suc(articelData)
            } else {
                let message = result["message"].stringValue
                let domain = "io.primas.ArticleAPI.getArticleMetadata.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                 err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    // MARK: - Read Article Content
    static func readArticle(
        dna: String,
        suc :@escaping ((_ content: String) -> ()),
        err :@escaping ResponseError)  {
        
        assert(!dna.isEmpty, "dna is empty")

        let url = PRIMAS_SERVER + post_Article + "/" + dna + "/content"
        
        NetWorkTool.requestGetWithUrl(url, suc: { (response) in
            debugPrint("readArticle ----- \(response)")
            let result = JSON(response)
            if result["success"].boolValue == true {
                let data = result["data"].stringValue
                suc(data)
            } else {
                let message = result["message"].stringValue
                let domain = "io.primas.ArticleAPI.readArticle.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }) { (error) in
            err(error)
            debugPrint(error)
        }
    }
    
    // MARK: - Get My articles
    static func getUserArticles(
        Start: String,
        Address:String!,
        Offset: Int,
        suc :@escaping ((_ articles: [ArticelModel]) -> ()),
        err :@escaping ResponseError)  {
        
        let address = Address ?? UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        
        let url = PRIMAS_SERVER + String.init(format: get_user_Articles, address)
        var params = ["offset" : String(Offset)]
        params["start"] = Start
        NetWorkTool.requestGetWithUrl(
            url,
            parameters: params,
            suc: { (response) in
                debugPrint("getUserArticles response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    let array = JSON(result["data"].rawString()?.data(using: .utf8) as Any).array
                    var results = [ArticelModel]()
                    for json in array! {
                        let articelData = ArticelModel.init(json: json)
                        results.append(articelData)
                    }
                    suc(results)
                } else {
                    let message = result["message"].isEmpty ? "unkonw" : result["message"].stringValue
                    let domain = "io.primas.GroupAPI.getUserArticles.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }) { (error) in
            debugPrint(error)
            err(error)
        }
        
        
    }
    
    // MARK: - Get user follow articles
    static func getUserFollowArticles(
        Start: String,
        Offset:String? = nil,
        suc :@escaping ((_ articles: [ArticelModel]) -> ()),
        err :@escaping ResponseError)  {

        let address = UserTool.shared.userAddress()
        assert(!address.isEmpty, "address.isEmpty")
        assert(!Start.isEmpty, "Start.isEmpty")

        let url = PRIMAS_SERVER + get_Articles
        var params = [String : Any]()
        params["address"] = address
        params["start"] = Start
        params["offset"] = Offset
        
        NetWorkTool.requestGetWithUrl(
            url,
            parameters: params,
            suc: { (response) in
                debugPrint("getUserArticles response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    let array = JSON(result["data"].rawString()?.data(using: .utf8) as Any).array
                        var results = [ArticelModel]()
                        for json in array! {
                            let articelData = ArticelModel.init(json: json)
                            results.append(articelData)
                        }
                        suc(results)
                } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.GroupAPI.getUserArticles.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }, err: err)
    }
    
    // MARK: - Get discovrModel
    static func discoverArticle(
        suc :@escaping ((_ articles: [ArticelModel]) -> ()),
        err :@escaping ResponseError)  {
        let url = PRIMAS_SERVER + get_Discover_Articles
        NetWorkTool.requestGetWithUrl(
            url,
            suc: { (response) in
                debugPrint(JSON(response))
                debugPrint("discoverArticle response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    let array = JSON(result["data"].rawString()?.data(using: .utf8) as Any).array
                        var results = [ArticelModel]()
                        for json in array! {
                            let articelData = ArticelModel.init(json: json)
                            results.append(articelData)
                        }
                        suc(results)
            } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.GroupAPI.discoverArticle.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
        }) { (error) in
            err(error)
        }
    }
    
    
    // MARK: - likes
    
    static func likes(
        passphrase:String,
        dna:String,
        GroupDNA: String,
        suc :@escaping (() -> ()),
        err :@escaping ResponseError) {
        
        let address = UserTool.shared.userAddress()
        
        assert(!passphrase.isEmpty, "passphrase.isEmpty")
        assert(!dna.isEmpty, "dna.isEmpty")
        assert(!address.isEmpty, "address.isEmpty")
        // assert(!GroupDNA.isEmpty, "GroupDNA.isEmpty")
        
        // Signature
        let signString = dna + GroupDNA
        
        SignatureTool.signHash(str: signString,  passphrase: passphrase, handle: { (sign) in
            
            let url = PRIMAS_SERVER + String.init(format: post_article_likes, dna)
            var params = [String : Any]()
            params["GroupDNA"] = GroupDNA
            params["GroupMemberAddress"] = address
            params["Signature"] = sign
            
            NetWorkTool.requestPostWithUrl(url, param: params,  suc: { (response) in
                debugPrint(UserTool.shared.userAddress())
                debugPrint("likes article response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    suc()
                } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.ArticleAPI.likes.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: err)
        }) { (error) in
            err(error)
        }
        
    }
    
    // MARK: - transmit article 转发
    static func transmit(
        passphrase:String,
        dna:String,
        GroupDNAs: [String],
        suc :@escaping (() -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        
        assert(!passphrase.isEmpty, "passphrase.isEmpty")
        assert(!dna.isEmpty, "dna.isEmpty")
        assert(!address.isEmpty, "address.isEmpty")
        assert(!GroupDNAs.isEmpty, "GroupDNAs.isEmpty")

        // Signature
        let sign_dnas = GroupDNAs.joined(separator: ",")
        let signString = dna + sign_dnas
        
        SignatureTool.signHash(str: signString,  passphrase: passphrase, handle: { (sign) in
            
            let url = PRIMAS_SERVER + String.init(format: post_to_groups, dna)
            var params = [String : Any]()
            params["GroupDNAs"] = GroupDNAs.first
            params["GroupMemberAddress"] = address
            params["Signature"] = sign
            debugPrint(params)
            
            NetWorkTool.requestPostWithUrl(url, param: params,  suc: { (response) in
                debugPrint(UserTool.shared.userAddress())
                debugPrint("transmit article response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    suc()
                } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.ArticleAPI.transmit.article.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: err)
        }) { (error) in
            err(error)
        }
        
    }
    
    // MARK: - comment article 评论

    static func comment(
        passphrase:String,
        dna:String,
        GroupDNA: String,
        Content: String,
        suc :@escaping (() -> ()),
        err :@escaping ResponseError)  {
        
        let address = UserTool.shared.userAddress()
        
        assert(!passphrase.isEmpty, "passphrase.isEmpty")
        assert(!dna.isEmpty, "dna.isEmpty")
        assert(!address.isEmpty, "address.isEmpty")
        assert(!Content.isEmpty, "Content.isEmpty")
        assert(!GroupDNA.isEmpty, "GroupDNA.isEmpty")

        // Signature
        let signString = dna + GroupDNA + Content.keccak256Hash
        
        SignatureTool.signHash(str: signString,  passphrase: passphrase, handle: { (sign) in
            
            let url = PRIMAS_SERVER + String.init(format: post_to_commnets, dna)
            var params = [String : Any]()
            params["GroupDNA"] = GroupDNA
            params["GroupMemberAddress"] = address
            params["Signature"] = sign
            params["Content"] = Content

            NetWorkTool.requestPostWithUrl(url, param: params,  suc: { (response) in
                debugPrint(UserTool.shared.userAddress())
                debugPrint("comment article response ---- \(response)")
                let result = JSON(response)
                if result["success"].boolValue == true {
                    suc()
                } else {
                    let message = result["message"].stringValue
                    let domain = "io.primas.ArticleAPI.comment.article.error"
                    let userInfo = [NSLocalizedDescriptionKey : message]
                    let error = NSError.init( domain: domain, code: -100, userInfo: userInfo)
                    err(error)
                }
            }, err: err)
        }) { (error) in
            err(error)
        }
    }
    
    // MARK: - Get article comment
    static func getComment(
        dna:String,
        Start: String,
        Offset:Int,
        suc :@escaping ((_ models: [CommentModel]) -> ()),
        err :@escaping ResponseError) {
        
        assert(!dna.isEmpty, "dna.isEmpty")
        assert(!Start.isEmpty, "start.isEmpty")

        let url = PRIMAS_SERVER + String.init(format: get_Article_comments, dna)
        let params = ["offset" : String(Offset), "start" : Start]
        NetWorkTool.requestGetWithUrl(url, parameters: params, suc: { (response) in
            debugPrint("article getComment response ---- \(response)")
            let res = ResponseModel.deserialize(from: response as? [String: Any])
            if res?.success == true {
                let arr = [CommentModel].deserialize(from: res?.data) as! [CommentModel]
                suc(arr)
            } else {
                let message = res?.message ?? "unknow"
                let domain = "io.primas.ArticleAPI.getComment.error"
                let userInfo = [NSLocalizedDescriptionKey : message]
                let error = NSError.init(domain: domain, code: -100, userInfo: userInfo)
                err(error)
            }
        }, err: err)
    }
}
