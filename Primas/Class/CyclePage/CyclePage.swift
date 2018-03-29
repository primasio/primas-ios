//
//  CyclePage.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import SnapKit
import EmptyKit

class CyclePage: BaseViewController {

    @IBOutlet weak var contentView: UIScrollView!
    @IBOutlet weak var follow_table: UITableView!
    @IBOutlet weak var discover_table: UITableView!
    @IBOutlet weak var segment: CustomSegment!
    
    fileprivate var follow_list = [CycleModel]()
    fileprivate var discover_list = [CycleModel]()
    
    fileprivate var followTimestamp = ""
    fileprivate var followOffset = request_start_offset
    
    fileprivate var discoverTimestamp = ""
    fileprivate var discoverOffset = request_start_offset
    
    fileprivate lazy var loginView:UIView = {
        let vc = Rstoryboard.noticeView.noticeLogin()!
        vc.display = .NoticeLogin_homePage
        vc.view.frame = follow_table.bounds
        vc.view.backgroundColor = Color_F7F7F7
        vc.createAction = {
            self.presentVc(Rstoryboard.builtWallet.builtWallet()!)
        }
        return vc.view
    }()
    
    let navbar = CustomNavBarView.navBar()
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color_F7F7F7
        navbar.backgroundColor = UIColor.white
        self.view.addSubview(navbar)
        navbar.leftBtn.isHidden = true
        navbar.title = Rstring.cycle_title.localized()
        navbar.titleLbl.font = UIFont.boldSystemFont(ofSize: 17)
        navbar.titleLbl.textColor = Rcolor.c333333()
        
        //segment.top = UIDevice.navTopOffset()
        segment.initSubvews()
        segment.updateTitle(left: Rstring.title_cicrcle_added.localized(), right: Rstring.cycle_discover.localized())
        
        initContentView()
        
        X_Notification.addObserver(
            self,
            selector: #selector(CyclePage.loginSuccess),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
        
        // without login
        if UserTool.shared.haveUser() {
            initRightbuutton()
            initFollowTable()
            initDiscover()
        } else {
            self.contentView.addSubview(self.loginView)
            initDiscover()
        }
        
    }
    
    func initRightbuutton()  {
        navbar.rightBtn.setTitle(Rstring.cycle_create.localized(), for: .normal)
        navbar.rightBtn.setTitleColor(Rcolor.ed5634(), for: .normal)
        navbar.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        navbar.rightBtn.addTarget(self, action: #selector(onRightAction),
                                  for: UIControlEvents.touchUpInside)
    }
    
    func initContentView() {
        contentView.contentSize = CGSize.init(width: kScreenW * 2, height: contentView.frame.size.height)
        contentView.isPagingEnabled = true
        contentView.backgroundColor = Color_F7F7F7
    }

    
    func initFollowTable()  {
        follow_table.backgroundColor = Color_F7F7F7
        follow_table.estimatedRowHeight = 0
        follow_table.register(Rnib.cycleCell)
        follow_table.ept.dataSource = self
        followTimestamp = Utility.currentTimeStamp()
        loadFollows(start: followTimestamp, offset: followOffset)
        
        // refresh data
        follow_table.initMJHeader {
            self.followTimestamp = Utility.currentTimeStamp()
            self.followOffset = request_start_offset
            self.loadFollows(start:  Utility.currentTimeStamp(),
                             offset: self.followOffset)
        }
        follow_table.initMJFooter {
            self.loadFollows(start:  self.followTimestamp,
                             offset: self.followOffset)
        }
    }
    
    @objc func loginSuccess()  {
        if self.contentView.subviews.contains(self.loginView) {
            self.loginView.removeFromSuperview()
        }
        initRightbuutton()
        initFollowTable()
    }
    
    func initDiscover()  {
        discover_table.backgroundColor = Color_F7F7F7
        discover_table.register(Rnib.cycleCell)
        discover_table.isHidden = true
        discover_table.ept.dataSource = self
        discover_table.estimatedRowHeight = 0
        
        // refresh data
        discover_table.initMJHeader {
            self.loadDiscovers()
        }
    }
    
    @IBAction func onSegmentChanged(sender :CustomSegment){
        if sender.selectedIndex == 0 {
            contentView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        }else {
            contentView.setContentOffset(CGPoint.init(x: kScreenW, y: 0), animated: true)
        }
    }
    
    @objc func onRightAction(){
        let vc = Rstoryboard.cyclePage.cycleCreatePage()!
        let nav = GesturePopNav.init(rootViewController: vc)
        self.presentVc(nav)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.navigationController!.isNavigationBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

extension CyclePage: CycleFollowDelegate{
    func onFollowClicked(cell: CycleCell) {
        //TODO: 接口待添加
        cell.model.follow_state = 1;
        cell.updateState()
    }
}
// MARK: data  TOTO:

extension CyclePage {
    
    func  curr_contentList(_ table: UITableView) -> Array<CycleModel> {
        if table == follow_table {
            return follow_list
        }else {
            return discover_list
        }
    }
    
    func curr_model(_ indexPath: IndexPath, _ table: UITableView) -> CycleModel! {
        if curr_contentList(table).count > indexPath.section && !curr_contentList(table).isEmpty {
            return curr_contentList(table)[indexPath.section]
        }else {
            return nil
        }
    }
    
    func loadFollows(start: String, offset: Int) {
        
        if offset == request_start_offset {
            self.follow_list.removeAll()
        }
        
        GroupApi.joinedGroups(Start: start, Offset: "\(offset)", suc: { (res) in
            for item in res {
                self.follow_list.append(item)
            }
            self.follow_table.reloadData()
            self.follow_table.endMJRefresh()
            if res.count < articles_page_size {
                self.follow_table.noMoreData()
            }
            self.followOffset += res.count
        }) { (error) in
            self.follow_table.endMJRefresh()
            self.hudShow(error.localizedDescription)
        }
    }
    
    func loadDiscovers() {
        GroupApi.discoverGroups(suc: { (res) in
            self.discover_list = res
            self.discover_table.reloadData()
            self.discover_table.endMJRefresh()
            self.cofigureLoadMore()
        }) { (error) in
            self.discover_table.endMJRefresh()
            self.hudShow(error.localizedDescription)
        }
    }
    
    // MARK: - Configure load more data
    func cofigureLoadMore()  {
        if self.discover_table.tableFooterView == nil {
         //   && self.discover_list.count >= articles_page_size {
            let button = UIButton.init(type: .custom)
            button.setTitle(Rstring.common_change_data.localized(), for: .normal)
            button.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 30)
            button.addAction(.touchUpInside) {
                self.discover_table.setContentOffset(.zero, animated: false)
                self.loadDiscovers()
            }
            button.setTitleColor(Rcolor.ed5634(), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            discover_table.tableFooterView = button
        }
    }
}


// MARK: - UITableViewDelegate / UITableViewDataSource
extension CyclePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return curr_contentList(tableView).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CycleCell = tableView.dequeueReusableCell(withIdentifier: Rnib.cycleCell.identifier, for: indexPath) as! CycleCell
        cell.inDiscover = (tableView == discover_table)
        cell.delegate = self
        let model = curr_model(indexPath, tableView)
        if model != nil {
            cell.model = model;
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 15))
        return view
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 15))
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
        let model = curr_model(indexPath, tableView)
        if model != nil {
            let cell: CycleCell = tableView.cellForRow(at: indexPath) as! CycleCell
            let vc = Rstoryboard.cyclePage.cycleIndexPage()
            vc?.cycleModel = model
            vc?.backImg = cell.cycleIcon.image
            pushVc(vc!)
        }

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ARTICLE_FOOT_HEIGHT
    }
}

extension CyclePage: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == contentView else {
            return
        }
        let scroll =  scrollView.contentOffset.x
        segment.selectedMask.left = scroll * 0.5
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == contentView else {
            return
        }
        let scroll =  scrollView.contentOffset.x
        let index = scroll / kScreenW
        segment.selectedIndex = Int(index)
        
        if segment.selectedIndex == 1 {
            if discover_table.isHidden == true {
                discover_table.isHidden = false
                loadDiscovers()
            }
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
}

// MARK: - EmptyDataSource
extension CyclePage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        if view == follow_table {
            return Utility.emptyAttributed(Rstring.common_no_subscription.localized())
        } else {
            return Utility.emptyAttributed(Rstring.common_no_content.localized())
        }
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return VerticalSpaceForEmpty
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        if view == follow_table {
            return Rimage.zanwuguanzhu()
        } else {
            return Rimage.zanwushuju()
        }
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}
