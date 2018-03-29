//
//  SettingPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/26.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class SettingPage: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let Identifier = "cell"
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: Identifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        X_Notification.addObserver(
            self,
            selector: #selector(SettingPage.setLocalized),
            name: GET_Notification_Name(.change_Language),
            object: nil)
        setLocalized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav(false)
    }
    
    @objc func setLocalized()  {
        self.navigationItem.title = Rstring.setting_PAGE.localized()
        tableView.reloadData()
    }
    
    func getTitle() -> [String] {
         let item1 = Rstring.account_backup.localized()
         let item2 = Rstring.set_LANGUAGE_TITLE.localized()
         let item3 = Rstring.set_SUGGES_TITLE.localized()
//         let item4 = Rstring.set_ABOUTUS_TITLE.localized()
         let item5 = Rstring.set_HEPLER_TITLE.localized()
         let item6 = Rstring.quit_Account.localized()
        if UserTool.shared.haveUser() {
            return [item1, item2, item3, item5, item6]
        } else {
            return [item2]
        }
    }
    
    func getIcon() -> [UIImage] {
        
        let icon1 = Rimage.beifen()!
        let icon2 = Rimage.组36()!
        let icon3 = Rimage.组33()!
        let icon4 = Rimage.guanyuwomen()!
        let icon5 = Rimage.bangzhu()!
        let icon6 = Rimage.tuichu()!
        
        if UserTool.shared.haveUser() {
            return [icon1, icon2, icon3, icon4, icon5, icon6]
        } else {
            return [icon2, icon3, icon4]
        }
    }
    
    
    // MARK: - Quit
    func quitAccount()  {
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { pwd in
            if UserTool.shared.haveUser() {
                let account = UserTool.shared.userAccount()
                GethTool.deleteAccount(
                    account: account,
                    passphrase: pwd,
                    handel: {
                        self.hudShow(Rstring.delete_SUCCEED.localized())
                        Utility.delay(0.5, closure: {
                            Utility.resetRootViewController()
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

// MARK: - UITableViewDelegate / UITableViewDataSource

extension SettingPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTitle().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath)
        let title = getTitle()[indexPath.row]
        let image = getIcon()[indexPath.row]
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = Rcolor.c333333()
        cell.imageView?.image = image
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let item1 = Rstring.account_backup.localized()
//        let item3 = Rstring.set_SUGGES_TITLE.localized()
//        let item4 = Rstring.set_ABOUTUS_TITLE.localized()
//        let item5 = Rstring.set_HEPLER_TITLE.localized()
//        let item6 = Rstring.quit_Account.localized()
        
        let cell = tableView.cellForRow(at: indexPath)
        let content = cell?.textLabel?.text
        
        // change language
        if content == Rstring.set_LANGUAGE_TITLE.localized() {
            pushVc(Rstoryboard.settingPage.languageSet()!)
        } else if content == Rstring.account_backup.localized() {
            let vc = Rstoryboard.builtWallet.backupPage()!
            vc.disply = .settingPage
            pushVc(vc)
        } else if content == Rstring.quit_Account.localized() {
           quitAccount()
        } else if content == Rstring.set_SUGGES_TITLE.localized() {
            let vc = Rstoryboard.settingPage.feedBackPage()!
            pushVc(vc)
        } else if content == Rstring.set_HEPLER_TITLE.localized() {
            let vc = Rstoryboard.settingPage.helpPage()!
            pushVc(vc)
        }
        
        
    }
    
}
