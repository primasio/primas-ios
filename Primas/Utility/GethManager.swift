//
//  GethManager.swift
//  Ethereum-test
//
//  Created by xuxiwen on 2017/10/30.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import Geth

let GethTool = GethManager.shared

final class GethManager: NSObject {
    
   //  fileprivate let node = GethNode.init(getNodePath(), config: GethNodeConfig())
    
     fileprivate let ks = GethNewKeyStore(getKeyStorePath(),
                                      GethLightScryptN,
                                      GethLightScryptP)
    
     private let gethClient = GethEthereumClient.init(TOKEN_UP_NETWORK)

     static var shared:GethManager = {
        let instance = GethManager();
        return instance;
    }();
    
    private override init() {}
    
    // MARK: - keystore instance
    func keyStore() -> GethKeyStore {
        return self.ks!
    }
    
    // MARK: - gethClient Instance
    func clientInstance() -> GethEthereumClient {
        //         return (try! node?.getEthereumClient())!
         return gethClient!
    }
    
    // MARK: - keyStore file path Setting
    fileprivate class func getKeyStorePath() -> String {
        let dataPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)[0] + "/keystore"
        debugPrint("keyStore File Path ---   \(dataPath)    ---")
        return dataPath
    }
    
    // MARK: - Node file path Setting
    fileprivate class func getNodePath() -> String {
        let dataPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)[0] + "/Node"
        debugPrint("Node File Path ---   \(dataPath)    ---")
        return dataPath
    }
    
    // MARK: - Creat new account
    func creatNewAccount(password: String,
                         handle: @escaping (_ account:GethAccount)->(),
                         err: @escaping errorBlock) {
        Utility.globalQueue {
            do {
                let newAcc = try self.ks!.newAccount(password)
                debugPrint("created new account hex address ---   \((newAcc.getAddress().getHex())!)   ---")
                Utility.safeMainQueue { handle(newAcc) }
            } catch {
                Utility.safeMainQueue {
                    debugPrint("creatNewAccount error -----\(error)")
                    err(error)
                }
            }
        }
    }
    
    // MARK: - update password
    func updatePassword(account: GethAccount,
                        passphrase: String,
                        handel: @escaping NoneBlock,
                        err: @escaping errorBlock) {
        Utility.globalQueue {
            do {
                try self.ks!.update(account, passphrase: passphrase, newPassphrase: passphrase)
                Utility.safeMainQueue { handel() }
            } catch {
                debugPrint("updatePassword --- error \(error)")
                Utility.safeMainQueue { err(error) }
            }
        }
    }
    
    // MARK: - Get all account
    func getAllAccount() -> GethAccounts {
        let allAcount = ks?.getAccounts()
         return allAcount!
    }
    
    // MARK: - judge exist account
    func existAccount() -> Bool {
        if getAllAccount().size() > 0 {
            return true
        }
        return false
    }
    
    // MARK: - get first account
    func getFirstAccount() -> GethAccount {
        let allAcount = ks!.getAccounts()
        return (try! allAcount?.get(0))!
    }
    
    // MARK: - delete account
    func deleteAccount(account: GethAccount,
                       passphrase: String,
                        handel: @escaping NoneBlock,
                        err: @escaping errorBlock ) {
        Utility.globalQueue {
            do {
                try self.ks!.delete(account, passphrase: passphrase)
                Utility.safeMainQueue { handel() }
            } catch {
                debugPrint("deleteAccount --- error \(error)")
                Utility.safeMainQueue { err(error) }
            }
        }
    }
    
    // MARK: - export Json Encryted
    func exportJsonEncrypted(account: GethAccount,
                             passphrase: String,
                             handle: @escaping (_ exportData:Data)->(),
                             err: @escaping errorBlock) {
        Utility.globalQueue {
            do {
                let jsonKey = try self.ks!.exportKey(account,
                                                passphrase: passphrase,
                                                newPassphrase: passphrase)
                Utility.safeMainQueue { handle(jsonKey) }
            } catch {
                debugPrint("exportJsonEncrypted --- error \(error)")
                Utility.safeMainQueue { err(error) }
            }
        }
    }
    
    // MARK: - import back the account
    func importJsonKey(jsonKey: Data,
                       passphrase: String,
                       handle: @escaping (_ account:GethAccount)->(),
                       err: @escaping errorBlock) {
        Utility.globalQueue {
        do {
            let impAcc  = try self.ks!.importKey(jsonKey,
                                         passphrase: passphrase,
                                         newPassphrase: passphrase)
            Utility.safeMainQueue { handle(impAcc) }
        } catch {
            Utility.safeMainQueue { err(error) }
            debugPrint("importJsonKey error -----\(error)")
            }
        }
    }
    
    // MARK: - get balance
    func getBalance(address: GethAddress,
                    num:Int64 = -1,
                    handle: @escaping (_ gethBigInt:GethBigInt)->(),
                    err: @escaping errorBlock) {
    
        Utility.globalQueue {
            do {
                let gethBalance = try self.gethClient!.getBalanceAt(GethContext(),
                                                                account: address,
                                                                number: num)
                Utility.safeMainQueue { handle(gethBalance) }
            } catch {
                Utility.safeMainQueue {  err(error) }
            }
        }
    }
    
    // MARK: - sign transaction
    func signTransaction(account:GethAccount,
                         passphrase:String,
                         tx:GethTransaction,
                         chain: GethBigInt,
                         handle: @escaping (_ gethTransaction:GethTransaction)->(),
                         err: @escaping errorBlock)   {
        Utility.globalQueue {
            do {
                let transaction = try self.ks!.signTxPassphrase(account,
                                                           passphrase: passphrase,
                                                           tx: tx,
                                                           chainID: chain)
                // debugPrint("sign transaction ---- \(transaction)")
                Utility.safeMainQueue { handle(transaction) }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("signTransaction error -----\(error)")
            }
        }
    }
    
    // MARK: - send transaction
    func sendTranscation(tx: GethTransaction,
                         handle: @escaping NoneBlock,
                         err: @escaping errorBlock) {
        Utility.globalQueue {
            do {
                try self.gethClient!.sendTransaction(GethContext(), tx: tx)
                Utility.safeMainQueue { handle() }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("sendTranscation error -----\(error)")
            }
        }
    }
    
    // MARK: - all transaction
    func getTransactions(address: String,
                         startBlockNumber: Int64,
                         endBlockNumber: Int64) -> [GethTransaction] {
        var transactions = [GethTransaction]()
        for blockNumber in startBlockNumber...endBlockNumber {
            let block = try! gethClient!.getBlockByNumber(GethNewContext(), number: blockNumber)
            let blockTransactions = block.getTransactions()!
            
            for index in 0...blockTransactions.size()  {
                guard let transaction = try? blockTransactions.get(index) else {
                    continue
                }
                let from = try? gethClient!.getTransactionSender(GethNewContext(), tx: transaction, blockhash: block.getHash(), index: index)
                let to = transaction.getTo()
                
                if to?.getHex() == address || from?.getHex() == address {
                    transactions.append(transaction)
                }
            }
        }
        return transactions
    }
    
    // MARK: - get suggestGas price
    func suggestGas( handle: @escaping (_ sugesstGas:GethBigInt)->(),
                     err: @escaping errorBlock){
        Utility.globalQueue {
            do {
                let value = try self.clientInstance().suggestGasPrice(GethContext())
                Utility.safeMainQueue { handle(value) }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("suggestGas error -----\(error)")
            }
        }
    }
    
    // MARK: - get estimateGas
    func estimateGas(fromAddress: String,
                     toAddress: String,
                     value: GethBigInt,
                     data: Data,
                     handle: @escaping (_ sugesstGas:GethBigInt)->(),
                     err: @escaping errorBlock){
        Utility.globalQueue {
            do {
                let callMsg = GethCallMsg()
                callMsg?.setFrom(GethAddress.init(fromHex: fromAddress))
                callMsg?.setTo(GethAddress.init(fromHex: toAddress))
                callMsg?.setValue(value)
                callMsg?.setData(data)
                let value = try self.clientInstance().estimateGas(GethContext(), msg: callMsg)
                Utility.safeMainQueue { handle(value) }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("estimateGas error -----\(error)")
            }
        }
    }
    
    // MARK: - get Pending Nonce
    func getPendingNonce(address: GethAddress,
                         handle: @escaping (_ nonce:Int64)->(),
                         err: @escaping errorBlock){
        Utility.globalQueue {
            do {
                var nonce:Int64 = 0
                try self.clientInstance().getPendingNonce(at: GethContext(),
                                                                      account:address,
                                                                      nonce: &nonce)
                Utility.safeMainQueue { handle(nonce) }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("getPendingNonce error -----\(error)")
            }
        }
    }
    
    // MARK: - Get Block high block Numbber
    func lastBlockHeight(handle: @escaping (_ blockHieht:Int)->(),
                         err: @escaping errorBlock)  {
        Utility.globalQueue {
            do {
                let ctx = GethContext()
                let lastest = try self.gethClient?.getBlockByNumber(ctx, number: -1)
                debugPrint("Latest block height: \(lastest!.getNumber().hashValue)")
                Utility.safeMainQueue { handle(lastest!.getNumber().hashValue) }
                return
            } catch {
                debugPrint("get lastBlockHeight error ----\(error)")
                Utility.safeMainQueue { err(error) }
            }
        }

    }
    
    // MARK: - sigh hash data
    func signHashData(
        account: GethAccount,
        passphrase: String,
        hashData: Data,
        handle: @escaping (_ data:Data) -> (),
        err: @escaping errorBlock) {
        Utility.globalQueue {
            do {
                let result = try self.ks?.signHashPassphrase(
                    account,
                    passphrase: passphrase,
                    hash: hashData)
                Utility.safeMainQueue { handle(result!) }
            } catch {
                Utility.safeMainQueue { err(error) }
                debugPrint("signHash error ----\(error)")
            }
        }
    }
    
    // MARK: - get chain
    func getChain() -> GethBigInt {
        if IS_TEST_NETWORK {
            return GethNewBigInt(Int64(TEST_NETWORK_CHAIN))
        } else {
            return GethNewBigInt(Int64(PRODUCT_NETWORK_CHAIN))
        }
    }
    
    // MARK: - bilitNewTranscation
    func bilitNewTranscation(nonce: Int64,
                             to:GethAddress,
                             amount:GethBigInt,
                             gasLimit:GethBigInt,
                             gasPrice:GethBigInt,
                             data:Data) -> GethTransaction {
        return GethNewTransaction(nonce, to, amount, gasLimit, gasPrice, data)
    }
    
    // MARK: - Remove cache keystore
    func removeALLKeystore() {
        let path = GethManager.getKeyStorePath()
        let fileTool = FileManager.default
        if fileTool.fileExists(atPath: path) {
            do {
                try fileTool.removeItem(atPath: path)
            } catch {
                debugPrint(error)
            }
        }
        
    }
}
