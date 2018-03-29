//
//  BackupPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot
import ethers

enum BackupPage_Type {
    case registerPage
    case settingPage
}

class BackupPage: BaseViewController {

    var disply:BackupPage_Type = .registerPage
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentMask: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = Rstring.set_backup_title.localized()
        contentMask.setBorderWidth(width: 1)
        contentMask.setBorderColor(color: Rcolor.e6E6E6())
        tableView.rowHeight = 123
        let word_style = StringStyle(
            .font(UIFont.systemFont(ofSize: 14)),
            .color(Rcolor.c666666()),
            .lineSpacing(3))
        contentLabel.attributedText = Rstring.set_backup_content.localized()
            .styled(with: word_style)
        
    }

    func dataArray() -> [ [String] ] {
        let item1 = [Rstring.use_nmonnic_backup.localized(), Rstring.set_level_high.localized(), Rstring.set_level_high.localized(), "0"]
        let item2 = [Rstring.use_keystore_backup.localized(), Rstring.set_level_middle.localized(), Rstring.set_level_high.localized(), "1"]
        let item3 = [Rstring.use_privatekey_backup.localized(), Rstring.set_level_high.localized(), Rstring.set_level_high.localized(), "1"]
        if disply == .registerPage {
            return [item1, item2, item3]
        } else {
            return [item2, item3]
        }
    }
    
    
    // MARK: - keystore backup
    func keystoreBackup()  {
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { pwd in
            if UserTool.shared.haveUser() {
                let account = UserTool.shared.userAccount()
                GethTool.exportJsonEncrypted(
                    account: account,
                    passphrase: pwd, handle: { (data) in
                        let json = String.init(data: data, encoding: .utf8)
                        debugPrint(json!)
                        vc.checkPassword(flag: true)
                        self.activityShare(info: json!)
                }, err: { (error) in
                    if IS_PwdError(error) {
                        vc.checkPassword(flag: false)
                    } else {
                        vc.checkPassword(flag: true)
                        self.hudShow(GethErrorLog(error))
                    }
                })
            }
        }
        self.navigationController?.presentVc(vc, animated: false)
    }
    
    func privateKeybackup() {
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { pwd in
            if UserTool.shared.haveUser() {
                let account = UserTool.shared.userAccount()
                GethTool.exportJsonEncrypted(
                    account: account,
                    passphrase: pwd,
                    handle: { (data) in
                        let json = String.init(data: data, encoding: .utf8)
                        Account.decryptSecretStorageJSON(
                            json,
                            password: pwd,
                            callback: { (account, error) in
                                let privateKey = SecureData.init(data: account?.privateKey).hexString()
                                debugPrint(privateKey!)
                                vc.checkPassword(flag: true)
                                self.activityShare(info: privateKey!)
                        })
                }, err: { (error) in
                    if IS_PwdError(error) {
                        vc.checkPassword(flag: false)
                    } else {
                        vc.checkPassword(flag: true)
                        self.hudShow(GethErrorLog(error))
                    }
                })
            }
        }
        self.navigationController?.presentVc(vc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension BackupPage:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.backupItemCell, for: indexPath)
        let array = dataArray()[indexPath.row]
        cell?.setItem(l1: array[1], l2: array[2], buttonName: array[0], style: array[3])
        
        if array[0] == Rstring.use_keystore_backup.localized() {
            cell?.handleAction = {  self.keystoreBackup() }
        } else if array[0] == Rstring.use_privatekey_backup.localized() {
            cell?.handleAction = {  self.privateKeybackup() }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
