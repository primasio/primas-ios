//
//  LanguageSet.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/26.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class LanguageSet: UITableViewController {

    fileprivate let reUseID = "CELLLL"
    fileprivate var dataArray:NSArray = []
    fileprivate var tempCell:UITableViewCell?
    fileprivate var tempString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reUseID)
        self.tableView.tableFooterView = UIView()
        tableView.rowHeight = 65
        setLocalized()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setLocalized() {
        let barItem = UIBarButtonItem.init(
            title: Rstring.common_Confirm.localized(),
            style: .plain,
            target: self,
            action: #selector(confirmSet))
        self.navigationItem.rightBarButtonItem = barItem
        self.navigationItem.title = Rstring.set_LANGUAGE_TITLE.localized()
        dataArray = Utility.initArrayFromPlist(plist: LANGUAGE_CODE_PLIST)
        tableView.reloadData()
    }
    
    @objc func confirmSet() {
            let temp = DeviceInfo.systemLauguageCode()
            if temp != tempString {
                Storage.cacheAppLanguageCode(tempString!)
                setLocalized()
                self.hudShow(Rstring.switch_LANGUAGE_SUCCEED.localized())
                // X_Notification.post(GET_Notification(.change_Language))
                Utility.delay(1, closure: {
                    Utility.resetRootViewController()
                    // self.navigationController?.popViewController(animated: true)
                })
            } else {
                self.navigationController?.popViewController(animated: true)
            }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reUseID, for: indexPath)
        cell.tintColor = Rcolor.ed5634()
        if  dataArray.count > 0 {
            let content:String = dataArray[indexPath.row] as! String
                let temp = DeviceInfo.systemLauguageCode()
                if temp == content {
                    cell.accessoryType = .checkmark
                    tempCell = cell
                    tempString = content
                }
                let string = Utility.getLanguageName(byCode: content)
                cell.textLabel?.text = string
            }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if  dataArray.count > 0 {
            let cell = tableView.cellForRow(at: indexPath)
            let content:String = dataArray[indexPath.row] as! String
                if  cell != tempCell  {
                    tempCell?.accessoryType = .none
                    cell?.accessoryType = .checkmark
                    tempCell = cell
                    tempString = content
                }
            }
    }

}
