//
//  HomeFindPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class HomeFindPage: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    fileprivate let hudOffset:CGFloat = -84
    var datas:[ArticelModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView
        tableView.register(Rnib.imageTextCell)
        tableView.backgroundColor = Color_F7F7F7
        tableView.ept.dataSource = self
        tableView.initMJHeader {  self.loadData()  }
        loadData()
    }

    // MARK: - Network request
    func loadData()  {
        ArticleAPI.discoverArticle(
            suc: { (models) in
                self.datas = models
                self.tableView.reloadData()
                self.cofigureLoadMore()
                self.tableView.endMJRefresh()
        }) { (error) in
            self.tableView.endMJRefresh()
            self.hudShow(error.localizedDescription, offset: self.hudOffset)
        }
    }
    
    // MARK: - Configure load more data
    func cofigureLoadMore()  {
        if self.tableView.tableFooterView == nil {
           // && self.datas.count >= articles_page_size {
            let button = UIButton.init(type: .custom)
            button.setTitle(Rstring.common_change_data.localized(), for: .normal)
            button.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 30)
            button.addAction(.touchUpInside) {
                self.tableView.setContentOffset(.zero, animated: false)
                self.loadData()
            }
            button.setTitleColor(Rcolor.ed5634(), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            tableView.tableFooterView = button
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension HomeFindPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.isEmpty ? 0 : 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ImageTextCell = tableView.dequeueReusableCell(withIdentifier: Rnib.imageTextCell.identifier, for: indexPath) as! ImageTextCell
        if !self.datas.isEmpty {
            let model = datas[indexPath.section]
            cell.setModel(articleModel: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.datas.isEmpty {
            let model = datas[indexPath.section]
            return ImageTextCell.getCellHeight(articleModel: model)
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(
            x: 0,
            y: 0,
            width: kScreenW,
            height: ARTICLE_FOOT_HEIGHT))
        view.backgroundColor = Color_F7F7F7
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // without loginin
        if !UserTool.shared.haveUser() {
            presentVc(Rstoryboard.builtWallet.builtWallet()!)
            return
        }
        
        if !self.datas.isEmpty {
            let model = datas[indexPath.section]
            let vc = Rstoryboard.homePage.articleDetail()
            vc?.dna = model.DNA!
            vc?.GroupDNA = model.GroupDNA!
            vc?.display = .article_detail
            pushVc(vc!)
        }

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 15))
        view.backgroundColor = Color_F7F7F7
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ARTICLE_FOOT_HEIGHT
    }
}

// MARK: - EmptyDataSource
extension HomeFindPage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return Utility.emptyAttributed(Rstring.common_no_content.localized())
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return VerticalSpaceForEmpty
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return Rimage.zanwushuju()
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}


