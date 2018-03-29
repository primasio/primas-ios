//
//  MinePage.swift
//  Primas
//
//  Created by figs on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class MinePage: BaseViewController {

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var contentView: UIScrollView!
    @IBOutlet weak var content_table: UITableView!
    @IBOutlet weak var cycle_table: UITableView!
    @IBOutlet weak var segment: CustomSegment!
    
    @IBOutlet weak var mineImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var updateIcon: UIImageView!
    @IBOutlet weak var codeLbl: UILabel!
    @IBOutlet weak var mineLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    
    //data
    var contentList = [ArticelModel]()
    var cycleList = [CycleModel]()
    var contentTimestamp = ""
    var contentOffset = request_start_offset
    var cycleTimestamp = ""
    var cycleOffset = request_start_offset
    let navBar = CustomNavBarView.navBar()
    
    var isOther = false
    var isFirst = true
    var isRootViewController = false
    
    lazy var loginView:UIView = {
        let vc = Rstoryboard.noticeView.noticeLogin()!
        vc.display = .NoticeLogin_minePage
        vc.view.frame = self.view.bounds
        vc.createAction = {
            self.presentVc(Rstoryboard.builtWallet.builtWallet()!)
        }
        vc.settingAction = {
            self.pushVc(Rstoryboard.settingPage.settingPage()!)
        }
        return vc.view
    }()
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    var mineUser = UserModel.testModel()
    
    // MARK: - views
    override func viewDidLoad() {
        super.viewDidLoad()
        X_Notification.addObserver(
            self,
            selector: #selector(MinePage.loginSuccess),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
        basicSetting()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.navigationController!.isNavigationBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        updateHP()
    }
    
    // Basic setting
    func basicSetting()  {
        // without login
        if !UserTool.shared.haveUser() {
            self.view.addSubview(self.loginView)
        } else {
            isRootViewController = self.navigationController?.viewControllers.first == self
            if isRootViewController {
                X_Notification.addObserver(
                    self,
                    selector: #selector(usernameUpdated(obj:)),
                    name: GET_Notification_Name(.username_updated),
                    object: nil)
            }
            initNavBar()
            initViews()
            initTableView()
            updateHeaderView()
            loadUserInfo()
            updateHP()
        }
    }
    
    let headTopOffset = UIDevice.navTopOffset()
    func initViews() {
        segment.width = kScreenW
        segment.initSubvews()
        headView.top = headTopOffset
        contentView.top = headView.bottom
        
        let upSwap = UISwipeGestureRecognizer.init(
            target: self,
            action: #selector(onSwapAction(sender:)))
        upSwap.direction = .up
        headView.addGestureRecognizer(upSwap)
        let downSwap = UISwipeGestureRecognizer.init(
            target: self,
            action: #selector(onSwapAction(sender:)))
        downSwap.direction = .down
        headView.addGestureRecognizer(downSwap)
        if isRootViewController {
            let tap = UITapGestureRecognizer.init(
                target: self,
                action: #selector(onTapAction(sender:)))
            nameLbl.addGestureRecognizer(tap)
            
//            let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(onChangeImageAction))
//            mineImage.addGestureRecognizer(tap2)
        }
    }
    
    func initTableView() {
        let contentHeight = UIDevice.height() - UIDevice.navTopOffset() - 46
        contentView.height = contentHeight
        contentView.isPagingEnabled = true
        contentView.backgroundColor = Color_F7F7F7
        var rect = contentView.bounds
        let width = kScreenW
        contentView.contentSize = CGSize.init(width: width * 2, height: contentView.height)
        contentView.isScrollEnabled = false
        content_table.frame = rect;
        content_table.estimatedRowHeight = 0
        content_table.ept.dataSource = self
        content_table.ept.delegate = self
        content_table.register(Rnib.imageTextCell)
        content_table.backgroundColor = Color_F7F7F7
        content_table.initMJHeader {
            self.contentOffset = request_start_offset
            self.loadContents(start: self.contentTimestamp, offset: self.contentOffset)
        }
        content_table.initMJFooter {
            self.loadContents(start: self.contentTimestamp, offset: self.contentOffset)
        }
        
        rect.origin.x = width
        cycle_table.frame = rect
        cycle_table.estimatedRowHeight = 0
        cycle_table.register(Rnib.mineCycleCell)
        cycle_table.backgroundColor = Color_F7F7F7
        cycle_table.ept.dataSource = self
        cycle_table.ept.delegate = self
        cycle_table.initMJHeader {
            self.cycleTimestamp = Utility.currentTimeStamp()
            self.cycleOffset = request_start_offset
            self.loadCycles(start: self.cycleTimestamp, offset: self.cycleOffset)
        }
        cycle_table.initMJFooter {
            self.loadCycles(start: self.cycleTimestamp, offset: self.cycleOffset)
        }
        contentTimestamp = Utility.currentTimeStamp()
        loadContents(start: contentTimestamp, offset: contentOffset)
        cycleTimestamp =  Utility.currentTimeStamp()
        loadCycles(start: cycleTimestamp, offset: cycleOffset)
    }
        
    func initNavBar(){
        self.view.addSubview(navBar)
        navBar.backgroundColor = UIColor.white
        navBar.showColor = Color_51
        navBar.rightBtn.setImage(Rimage.shezhi(), for: .normal)
        navBar.title = mineUser.Name
        navBar.isInRootView = isRootViewController
        navBar.delegate = self
        mineLbl.text = Rstring.mine_grade.localized() + " A"
        hpLbl.text = Rstring.mine_hp().localized + " 0"
        let avatarW: CGFloat = 75
        mineImage.width = avatarW
        mineImage.setCornerRadius(radius: 75 / 2)
        mineImage.contentMode = .scaleAspectFill
        mineImage.image = Utility.randomAvatar()
    }
    
    func updateHeaderView() {
        UserTool.shared.getUserModel(handle: { (user) in
            self.nameLbl.text = user.Name
            self.navBar.title = user.Name
            self.content_table.reloadData()
        }) { (error) in
            self.hudShow(error.localizedDescription)
            debugPrint(error.localizedDescription)
        }

        codeLbl.text = UserTool.shared.userAddress()
        updateIcon.left = nameLbl.left + nameLbl.widthFitHeight() + 10
        
        //刷新title
        var left = isOther ? Rstring.mine_content_other.localized() : Rstring.mine_content.localized()
        let leftCount = mineUser.ArticleCount
        if leftCount>0{
            left += String.init(format: "(%d)", leftCount)
        }
        var right = isOther ? Rstring.mine_cycle_other.localized() : Rstring.mine_cycle.localized()
        let rightCount = mineUser.GroupCount
        if rightCount>0{
            right += String.init(format: "(%d)", rightCount)
        }
        segment.updateTitle(left: left, right: right)
    }
    
    @objc func usernameUpdated(obj: NSNotification){
        nameLbl.text = obj.object as? String
        updateIcon.left = nameLbl.left + nameLbl.widthFitHeight() + 10
    }

    @objc func loginSuccess()  {
        if self.view.subviews.contains(self.loginView) {
            self.loginView.removeFromSuperview()
        }
        basicSetting()
    }
    
    func updateHP()  {
        guard Have_User() else { return }
        ValueAPI.getHP(
            suc: { value in
                    self.hpLbl.text = Rstring.mine_hp().localized + " " + value
        }) { (error) in
            debugPrint(error)
            self.hudShow(error.localizedDescription)
        }
    }
    
    @IBAction func onSegmentChanged(sender :CustomSegment){
        if sender.selectedIndex == 0 {
            contentView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        } else {
            contentView.setContentOffset(CGPoint.init(x: contentView.frame.size.width, y: 0), animated: true)
        }
    }
    @objc func onTapAction(sender: UITapGestureRecognizer){
        let update = UpdatePage()
        update.userModel = mineUser
        pushVc(update)
    }

    @objc func onSwapAction(sender: UISwipeGestureRecognizer){
        let minOffset = -segment.top + UIDevice.navTopOffset()
        let maxOffset = UIDevice.navTopOffset()
        let topOffset = sender.direction == .down ? maxOffset : minOffset
        UIView.animate(withDuration: 0.3) {
            self.headView.top = topOffset
            self.contentView.top = self.headView.bottom
            self.navBar.titleLbl.textColor = Color_51.withAlphaComponent((maxOffset-topOffset)/44)
        }
    }
    


    @IBAction func onChangeImageAction() {
        PohtoManage.shared.choosePicture(self, editor: true) { (image) in
            self.mineImage.image = image
        }
    }
}

extension MinePage {
    
    func  curr_contentList(_ table: UITableView) -> [Any] {
        if table == content_table {
            return contentList
        }else {
            return cycleList
        }
    }
    
    func curr_model(_ indexPath: IndexPath, _ table: UITableView) -> Any! {
        if curr_contentList(table).count > indexPath.section {
            return curr_contentList(table)[indexPath.section]
        } else {
            return nil
        }
    }
    
    func loadUserInfo(){
        self.cycleTimestamp = Utility.currentTimeStamp()
        self.contentTimestamp = cycleTimestamp
        UserAPI.getUserInfo(Address: mineUser.Address, suc: { (res) in
            self.mineUser = res
            self.updateHeaderView()
        }) { (error) in
            self.hudShow(error.localizedDescription)
            debugPrint(error.localizedDescription)
        }
    }
    
    func loadContents(start:String, offset: Int) {
        
        ArticleAPI.getUserArticles(
            Start: start,
            Address: mineUser.Address,
            Offset: offset,
            suc: { (res) in
                
                if offset == request_start_offset {
                    self.content_table.resetNoMoreData()
                    self.contentList.removeAll()
                }
                for cycle in res {
                    self.contentList.append(cycle)
                }
                self.content_table.reloadData()
                self.content_table.endMJRefresh()
                self.contentOffset += res.count
                if res.count < articles_page_size {
                    self.content_table.noMoreData()
                }
        }) { (error) in
            self.content_table.endMJRefresh()
            self.hudShow(error.localizedDescription)
        }
    }

    func loadCycles(start:String, offset: Int) {
        
        GroupApi.userGroups(
            Start:start,
            Address: mineUser.Address,
            suc: { (res) in
                if offset == request_start_offset {
                    self.cycle_table.resetNoMoreData()
                    self.cycleList.removeAll()
                }

                for cycle in res {
                    self.cycleList.append(cycle)
                }
                
            self.cycle_table.reloadData()
            self.cycle_table.endMJRefresh()
            self.cycleOffset += res.count
                if res.count < articles_page_size {
                    self.cycle_table.noMoreData()
                }
        }) { (error) in
            self.cycle_table.endMJRefresh()
            self.hudShow(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension MinePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == content_table {
            return contentList.count
        }
        return cycleList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == content_table{
            let cell:ImageTextCell = tableView.dequeueReusableCell(withIdentifier: Rnib.imageTextCell.identifier, for: indexPath) as! ImageTextCell
            if !contentList.isEmpty {
                let model = contentList[indexPath.section]
                model.Author?.Name = self.nameLbl.text
                cell.setModel(articleModel: model)
            }
            return cell
        }
        let cell:MineCycleCell = tableView.dequeueReusableCell(withIdentifier: Rnib.mineCycleCell.identifier, for: indexPath) as! MineCycleCell
        let model = curr_model(indexPath, tableView)
        cell.model = model as! CycleModel
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == content_table {
            if contentList.isEmpty { return 0 }
            let model = contentList[indexPath.section]
            return ImageTextCell.getCellHeight(articleModel: model)
        }
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == content_table {
            if !contentList.isEmpty {
            let model = contentList[indexPath.section]
            let vc = Rstoryboard.homePage.articleDetail()
            vc?.dna = model.DNA!
            vc?.GroupDNA = ""
            vc?.display = .transmit_article
                pushVc(vc!)
            }
            return
        }
        
        if !cycleList.isEmpty {
            let cell: MineCycleCell = tableView.cellForRow(at: indexPath) as! MineCycleCell
            let model = self.cycleList[indexPath.section]
            let vc = Rstoryboard.minePage.mineCyclePage()
            vc?.circleImg = cell.cycleIcon.image
            vc?.cycleModel = model
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
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentView {
            let scroll =  scrollView.contentOffset.x
            segment.selectedMask.left = scroll * 0.5
            return
        }
        
        let minOffset = -segment.top + UIDevice.navTopOffset()
        let maxOffset = UIDevice.navTopOffset()
        var topOffset = headView.top
        
        var offset = scrollView.contentOffset
        topOffset -= offset.y
        
        if topOffset > maxOffset {
            topOffset = maxOffset
        } else if topOffset < minOffset {
            topOffset = minOffset
        } else {
            offset.y = 0
            scrollView.contentOffset = offset
        }
        if headView.top !=  topOffset {
            headView.top = topOffset
            contentView.top = headView.bottom
            navBar.titleLbl.textColor = Color_51.withAlphaComponent((maxOffset-topOffset)/44)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == contentView else { return }
        let scroll =  scrollView.contentOffset.x
        let index = scroll / kScreenW
        segment.selectedIndex = Int(index)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
}

extension MinePage: CustomNavBarViewDelegate {
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    func rightAction() {
        self.pushVc(Rstoryboard.settingPage.settingPage()!)
    }
}

// MARK: - EmptyDataSource
extension MinePage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        var title = ""
        if view == content_table {
            title = Rstring.cycle_no_content_tip.localized()
        } else {
           title = Rstring.create_cicrcle_prompt.localized()
        }
        
        let font = UIFont.systemFont(ofSize: 13)
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: Rcolor.c333333(), .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func verticalOffsetForEmpty(in view: UIView) -> CGFloat {
        return -(headView.height / 2) + 15
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return 14
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        if view == content_table {
             return Rimage.qufabu()
        } else {
            return Rimage.quchuangjian()
        }
    }
    
    func buttonTitleForEmpty(forState state: UIControlState, in view: UIView) -> NSAttributedString? {
        var title = ""
        if view == content_table {
            title = Rstring.cycle_go_write.localized()
        } else {
            title = Rstring.go_to_create.localized()
        }
        let font = UIFont.systemFont(ofSize: 16)
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: Rcolor.ed5634(), .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}

extension MinePage: EmptyDelegate {
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        if view == content_table {
             self.presentPostVc()
        } else {
            let vc = Rstoryboard.cyclePage.cycleCreatePage()!
            let nav = GesturePopNav.init(rootViewController: vc)
            self.presentVc(nav)
        }
     }
}
