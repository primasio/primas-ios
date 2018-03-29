//
//  UserTool.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import Geth

class UserTool: NSObject {

    static let shared = UserTool.init()
    private override init(){}
    fileprivate var userModel:UserModel?
    
    // MARK: - Judge Exist account
    func haveUser() -> Bool {
        return GethManager.shared.existAccount()
    }
    
    // MARK: - Get Current Account addres
    func userAddress() -> String {
        if self.haveUser() {
            let account =  GethManager.shared.getFirstAccount()
            return account.getAddress().getHex()
        } else {
            return ""
        }
    }
    // MARK: - Set user model
    func initUserModel(user: UserModel) {
        self.userModel = user
    }
    // MARK: - Clear user
    func cleaarUser()  {
        self.userModel = nil
    }
    
    // MARK: - Get User Geth account
    func userAccount() -> GethAccount {
        if haveUser() {
            return GethManager.shared.getFirstAccount()
        } else {
            assertionFailure("no exit account")
            return GethAccount()
        }
    }
    
    // MARK: - Get user model
    func getUserModel(
        update: Bool = false,
        handle:@escaping (_ user: UserModel) -> (),
        err :@escaping ResponseError)  {
        
        guard UserTool.shared.haveUser() else {  return }
        
        if self.userModel != nil && !update {
            handle(self.userModel!)
            return
        }
        UserAPI.getUserInfo(
            Address:nil,
            suc: { (userModel) in
            self.userModel = userModel
            handle(userModel)
        }, err: err)
    }
    
    /*
    func burnAction()  {
        self.getUserModel(
            handle: { (user) in
                if user.TokenBurned == "0" {
                    ValueAPI.burn(suc: {
                        
                    }) { (error) in
                        
                        
                        
                        debugPrint(error.localizedDescription)
                    }
                }
        }) { (error) in
            
            debugPrint(error.localizedDescription)
        }
    }
 */
    
}
