//
//  APIConst.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation

/*
 # Port
 
 ## Aliyun
 
 * Foundation Node: 47.100.124.76:8545
 * Ropsten Server 47.100.124.76:8595
 
 * Ropsten Node: 101.132.139.155:8545
 * Foundation Server 101.132.139.155:8595
 
 ## AWS
 
 * Ropsten Node: https://node.ropsten.tokenup.io
 * Ropsten Server: https://server.ropsten.tokenup.io
 * Foundation Node: https://node.foundation.tokenup.io
 * Foundation Server: https://server.foundation.tokenup.io
 
 
 */

// geth ropsten
let TOKEN_UP_NETWORK_ROPSTEN = "https://node.ropsten.tokenup.io"
// geth foundation
let TOKEN_UP_NETWORK_FOUNDATION = "https://node.foundation.tokenup.io"

let TEST_NETWORK_CHAIN = 3
let PRODUCT_NETWORK_CHAIN = 1
let IS_TEST_NETWORK = ApiAddress.isTestNetWork()

// Geth server
let TOKEN_UP_NETWORK = ApiAddress.netWorkBaseAddress(IS_TEST_NETWORK)
// Primas server
let PRIMAS_SERVER = "http://ec2-13-230-207-128.ap-northeast-1.compute.amazonaws.com:8080"

// "http://172.20.37.106:8080"
// "http://ec2-13-230-207-128.ap-northeast-1.compute.amazonaws.com:8080"

/// Primas API

// About User
let update_UserInfo = "/v1/users" // update user info
// About Article
let post_Article = "/v1/articles" // post article
let get_Articles = "/v1/articles" // get articles data
let get_Discover_Articles = "/v1/discover/articles" //  Discover Articles
let post_article_likes = "/v1/articles/%@/likes" // likes action
let post_to_groups = "/v1/articles/%@/groups" // likes action
let post_to_commnets = "/v1/articles/%@/comments" // comment article
let get_user_Articles = "/v1/users/%@/articles" // get user articles

let get_Article_comments = "/v1/articles/%@/comments" // get article comments

//Create group
let create_group = "/v1/groups"

//discover group
let discover_group = "/v1/discover/groups"

//follow group
let follow_group = "/v1/groups/follow"

let get_user_groups = "/v1/users/%@/groups" // get user groups

//join group
let join_group = "/v1/groups/%@/members"

//exit group
let exit_group = "/v1/groups/%@/members/delete"
//remove_group
let remove_group = "/v1/groups/%@/members/delete/owner"

//groups_articles
let groups_articles = "/v1/groups/%@/articles"

// user_groups_articles
let user_groups_articles = "/v1/users/%@/groups/%@/articles"

//groups_info
let groups_info = "/v1/groups/%@"

/// Value  API

// get hp
let get_hp_value = "/v1/users/%@/hp"
// get balance
let get_balance_value = "/v1/users/%@/balance"
// get balance locked
let get_balance_locked = "/v1/users/%@/balance/locked"
// get user burn
let gert_user_burn = "/v1/users/%@/burn"
// get  incentives
let get_incentives = "/v1/incentives"
// get  article incentives
let get_article_incentives = "/v1/incentives/articles/%@"

class ApiAddress: NSObject {
    
    // MARK: -  Judege IS TestNetWork
    ///
    /// - Returns: Bool Value
    class func isTestNetWork() -> Bool {
        return false
    }
    
    // MARK: -  Get geth NetWork
    ///
    /// - Parameter isTest: isTest Network
    /// - Returns: Base Address String
    class func netWorkBaseAddress(_ isTest:Bool) -> String {
        if isTest {
            return TOKEN_UP_NETWORK_ROPSTEN
        } else {
            return TOKEN_UP_NETWORK_FOUNDATION
        }
    }

}
