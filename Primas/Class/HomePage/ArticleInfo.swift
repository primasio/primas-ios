//
//  ArticleInfo.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/3.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit

class ArticleInfo: UITableViewController {

    fileprivate let cellIdentify = "ArticleInfo"
    fileprivate let cellNums = 7
    fileprivate var model: ArticelModel!
    let subTitleFont = UIFont.systemFont(ofSize: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Rstring.blockchain_info.localized()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: cellIdentify)
        tableView.separatorStyle = .none
        
        let view = UIView.init(frame: CGRect.init(origin: .zero,
                                                  size: CGSize.init(
                                                    width: kScreenW,
                                                    height: 20)))
        view.backgroundColor = UIColor.white
        tableView.tableHeaderView = view
        
    }

    func setData(model: ArticelModel)  {
        self.model = model
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNums
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return getCellHeight(str: model.Title!)
        case 1:
            return getCellHeight(str:  model?.Author?.Name == "" ? "--" : (model?.Author?.Name)!)
        case 2:
            return getCellHeight(str: (model?.CreatedAt?.toTimeString())!)
        case 3:
            return getCellHeight(str: (model?.DNA?.substring(from: 0, to: 8))!)
        case 4:
            return getCellHeight(str:(model?.BlockHash)!)
        case 5:
            return getCellHeight(str: (model?.ContentHash)!)
        case 6:
            return getCellHeight(str: model?.Author?.Signature == "" ? "--" : (model?.Author?.Signature)!)
        default:
            return 80
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: cellIdentify)
        cell.textLabel?.textColor = Rcolor.c333333()
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = Rcolor.c666666()
        cell.detailTextLabel?.font = subTitleFont
        cell.detailTextLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = Rstring.post_title_place.localized()
            cell.detailTextLabel?.text = model.Title
            break
        case 1:
            cell.textLabel?.text = Rstring.common_author.localized()
            cell.detailTextLabel?.text = model?.Author?.Name == "" ? "--" : model?.Author?.Name
            break
        case 2:
            cell.textLabel?.text = Rstring.common_publish_time.localized()
            cell.detailTextLabel?.text = model?.CreatedAt?.toTimeString()
            break
        case 3:
            cell.textLabel?.text = Rstring.common_dna.localized()
            cell.detailTextLabel?.text = model?.DNA?.substring(from: 0, to: 8)
            break
        case 4:
            cell.textLabel?.text = Rstring.blockchain_address.localized()
            cell.detailTextLabel?.text = model?.BlockHash
            break
        case 5:
            cell.textLabel?.text = Rstring.article_hash.localized()
            cell.detailTextLabel?.text = model?.ContentHash
            break
        case 6:
            cell.textLabel?.text = Rstring.common_signature.localized()
            cell.detailTextLabel?.text = model?.Author?.Signature == "" ? "--" : model?.Author?.Signature
            break
        default:
            break
        }
        
        return cell
    }

    func getCellHeight(str: String) -> CGFloat {
        let margin = CGFloat.init(30 * 2)
        return Utility.heightForView(text: str, font: subTitleFont, width: kScreenW - margin) + 30
    }
}
