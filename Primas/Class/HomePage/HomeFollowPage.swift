//
//  HomeFollowPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class HomeFollowPage: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate var tempTimestamp = ""
    fileprivate var tempOffset = request_start_offset
    fileprivate let hudOffset:CGFloat = -84
    
    var datas:[ArticelModel] = []
    
    lazy var loginView:UIView = {
        let vc = Rstoryboard.noticeView.noticeLogin()!
        vc.display = .NoticeLogin_homePage
        vc.view.frame = self.view.bounds
        vc.view.backgroundColor = Color_F7F7F7
        vc.createAction = {
            self.presentVc(Rstoryboard.builtWallet.builtWallet()!)
        }
        return vc.view
    }()
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        X_Notification.addObserver(
            self,
            selector: #selector(HomeFollowPage.loginSuccess),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
        
        // without login
        if !UserTool.shared.haveUser() {
            self.view.addSubview(self.loginView)
        } else {
            basicSeeting()
        }
    }

    // basic seeting
    func basicSeeting()  {
        // tableView
        tableView.register(Rnib.imageTextCell)
        tableView.backgroundColor = Color_F7F7F7
        tableView.emptyFooter()
        tableView.ept.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        // refresh data
        tableView.initMJHeader {
            self.tempTimestamp = Utility.currentTimeStamp()
            self.tempOffset = request_start_offset
            self.tableView.resetNoMoreData()
            self.network(start:  Utility.currentTimeStamp(),
                         offset: self.tempOffset)
        }
        tableView.initMJFooter {
            self.network(start:  self.tempTimestamp,
                         offset: self.tempOffset)
        }
        // request data
        tempTimestamp = Utility.currentTimeStamp()
        network(start: tempTimestamp, offset: tempOffset)
    }
    
    @objc func loginSuccess()  {
        if self.view.subviews.contains(self.loginView) {
            self.loginView.removeFromSuperview()
        }
        basicSeeting() 
    }

    // MARK: - Network
    func network(start: String, offset: Int)  {
        ArticleAPI.self.getUserFollowArticles(
            Start: start,
            Offset: "\(offset)",
            suc: { (articles) in
                if offset == request_start_offset {
                    self.datas.removeAll()
                }
                for model in articles {
                    self.datas.append(model)
                }
                self.tableView.endMJRefresh()
                self.tempOffset += articles.count
                if articles.count < articles_page_size {
                    self.tableView.noMoreData()
                }
                self.tableView.reloadData()
        }) { (error) in
            self.tableView.endMJRefresh()
            self.hudShow(error.localizedDescription, offset: self.hudOffset)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension HomeFollowPage: UITableViewDelegate, UITableViewDataSource {
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
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - EmptyDataSource
extension HomeFollowPage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return Utility.emptyAttributed(Rstring.common_no_subscription.localized())
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return VerticalSpaceForEmpty
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return Rimage.zanwuguanzhu()
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}

