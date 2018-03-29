//
//  CycleIndexPage.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class CycleIndexPage: BaseViewController, CustomNavBarViewDelegate {

    @IBOutlet weak var cycleImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cycleTitle: UILabel!
    @IBOutlet weak var cycleInfo: UILabel!
    @IBOutlet weak var cycleDes: UILabel!
    @IBOutlet weak var cycleMember: CycleMemberView!
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var craeteBtnH: NSLayoutConstraint!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var moreDesBtn: UIButton!
    
    @IBOutlet weak var changeBtn: UIButton!
    
    fileprivate var tempTimestamp = ""
    fileprivate var tempOffset = request_start_offset
    
    var titleBar: UINavigationBar!
    var backImg: UIImage?
    
    var navBarView: CustomNavBarView!
    var cycleModel: CycleModel!
    
    var showMoreDes = false
    
    var contentList = [ArticelModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if backImg != nil {  cycleImage.image = backImg }
        
        if cycleModel != nil {
            updateHeaderView()
            setNavBar()
            setTableView()
            if cycleModel.TxStatus == 1 {
                updateCreateBtn()
            } else if cycleModel.TxStatus == 2 {
                loadGroupInfo()
                loadData()
            }
            let tap = UITapGestureRecognizer.init(
                target: self,
                action: #selector(onChangeImageAction))
            cycleImage.addGestureRecognizer(tap)
        }
    }
    
    
    func setTableView(){
        /*
        if cycleModel.UserAddress == UserTool.shared.userAddress() {
            changeBtn.isHidden = false
        }
        */ 
        //header
        tableView.tableHeaderView = headView
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        // followBtn.addCorner(roundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue)|UInt8(UIRectCorner.bottomLeft.rawValue))), cornerSize: followBtn.size)
        followBtn.isHidden = true
        createBtn.isHidden = true
        craeteBtnH.constant = 0
        self.view.backgroundColor = Color_fafafa
        tableView.backgroundColor = Color_fafafa
        tableView.register(Rnib.imageTextCell)
        if #available(iOS 11.0, *) {
            tableView.contentInset = UIEdgeInsetsMake(-UIDevice.statusTopOffset(), 0, 0, 0)
        }
    }
    
    func loadData() {
        tableView.initMJHeader {
            self.tempTimestamp = Utility.currentTimeStamp()
            self.tempOffset = request_start_offset
            self.tableView.resetNoMoreData()
            self.loadData(start: self.tempTimestamp, offset: self.tempOffset)
        }
        tableView.initMJFooter {
            self.loadData(start: self.tempTimestamp, offset: self.tempOffset)
        }
        //self.tempTimestamp = Utility.currentTimeStamp()
        //loadData(start: tempTimestamp, offset: tempOffset)
    }
    
    func setNavBar() {
        navBarView = CustomNavBarView.navBar()
        self.view.addSubview(navBarView)
        navBarView.delegate = self
        navBarView.title = cycleModel.Title
        navBarView.rightBtn.setImage(Rimage.item_more()?.original(), for: .normal)
    }
    
    //返回
    func leftAction() {
        if cycleModel.TxStatus == 1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.navigationController?.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    //右键
    func rightAction() {
        if cycleModel.TxStatus == 0 {//未加入加入
            self.handelGroup(type: 0)
            return
        }
        let tip = Rstring.cycle_exit_tip(cycleModel.Title)
        let action = UIAlertController.init(title: tip, message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        action.addAction(UIAlertAction.init(title: Rstring.cycle_exit.localized(), style: UIAlertActionStyle.destructive, handler: { (action) in
        }))
        action.addAction(UIAlertAction.init(title: Rstring.cancel_BUTTON.localized(), style: UIAlertActionStyle.cancel, handler: { (action) in
            self.exitGroupAction()
        }))
        let popover = action.popoverPresentationController
        if (popover != nil) {
            popover?.sourceView = self.view
            popover?.sourceRect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        }
        self.presentVc(action)
    }

    func exitGroupAction()  {
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { pwd in
            if UserTool.shared.haveUser() {
                let account = UserTool.shared.userAccount()
                GethTool.deleteAccount(
                    account: account,
                    passphrase: pwd,
                    handel: {
                        self.exitGroup(pwd: pwd)
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
    
    //底部按钮更新
    func updateCreateBtn(){
        debugPrint(cycleModel.TxStatus)
        if cycleModel.TxStatus == 1 {
            waitAuditting()
        } else {
            if cycleModel.IsMember == nil {
                // 加入
                createBtn.setTitle(Rstring.cycle_join.localized(), for: .normal)
                createBtn.setTitleColor(UIColor.white, for: .normal)
                createBtn.backgroundColor = Color_custom_red
                createBtn.setImage(nil, for: .normal)
                navBarView.rightBtn.isHidden = true
                craeteBtnH.constant = 45
                createBtn.isHidden = false
                createBtn.isUserInteractionEnabled = true

            } else {
                // 写文章
                /*
                 createBtn.setTitle(Rstring.cycle_write_article.localized(), for: .normal)
                 createBtn.setTitleColor(Color_title_black, for: .normal)
                 createBtn.backgroundColor = UIColor.init(red: 205, green: 205, blue: 205, alpha:0.96)
                 createBtn.setImage(nil, for: .normal)
                 */
                if cycleModel.IsMember!.TxStatus == "1" {
                    waitAuditting()
                } else {
                    createBtn.isHidden = true
                    craeteBtnH.constant = 0
                    navBarView.rightBtn.isHidden = false
                    createBtn.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    // 无法操作的状态
    func waitAuditting()  {
        createBtn.setTitle(Rstring.post_to_auditting.localized(), for: .normal)
        createBtn.setTitleColor(UIColor.white, for: .normal)
        createBtn.backgroundColor = UIColor.gray
        createBtn.setImage(nil, for: .normal)
        navBarView.rightBtn.isHidden = true
        craeteBtnH.constant = 45
        createBtn.isHidden = false
        createBtn.isUserInteractionEnabled = false
    }
    
    @IBAction func onCreateAction(){
    
        if cycleModel.join_state == 0 {//未加入
            enoughBalance(usePst: CREATE_CIRCLE_PST) { (flag) in
                if flag {
                    self.handelGroup(type: 0)
                } else {
                    self.presentNoPST(disPlay: .join_circle)
                }
            }
            
            return
        }
        self.goWriteArticle()
    }
    
    //写文章
    @objc func goWriteArticle(){
        presentPostVc()
    }
    
    func updateFollowBtn(){
        if cycleModel.follow_state == 0{
            followBtn.setTitle(Rstring.cycle_un_followed.localized(), for: .normal)
            followBtn.backgroundColor = Color_custom_red
            followBtn.setTitleColor(UIColor.white, for: .normal)
        }else {
            followBtn.setTitle(Rstring.cycle_followed.localized(), for: .normal)
            followBtn.backgroundColor = Color_245
            followBtn.setTitleColor(Color_153, for: .normal)
        }
    }
    
    @IBAction func onFollowAction(){
        if cycleModel.follow_state == 0 {//go follow
            self.handelGroup(type: 2)
            return
        }
        
        let tip = Rstring.cycle_unfollow_tip.localized()
        let action = UIAlertController.init(title: tip, message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        action.addAction(UIAlertAction.init(title: Rstring.cycle_cancel_follow.localized(), style: UIAlertActionStyle.destructive, handler: { (action) in
            self.handelGroup(type: 3)
        }))
        action.addAction(UIAlertAction.init(title: Rstring.cancel_BUTTON.localized(), style: UIAlertActionStyle.cancel, handler: { (action) in
            
        }))
        let popover = action.popoverPresentationController
        if (popover != nil) {
            popover?.sourceView = self.view
            popover?.sourceRect = CGRect.init(x: 0, y: 0, width: 1, height: 2)
        }
        self.presentVc(action)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.navigationController!.isNavigationBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    lazy var emptyView: CustomEmptyView = {
        let height = UIDevice.height() - headView.height
        let view = CustomEmptyView.emptyView(height: height)
        view.showCycleIndexEmpty()
        return view
    }()
}

// MARK: - Header
extension CycleIndexPage{
    func updateHeaderView() {
        cycleTitle.text = cycleModel.Title
        cycleInfo.text = cycleModel.get_info_string()
        cycleDes.text = cycleModel.Description
        
        var height = cycleDes.heightFitWith()
        if showMoreDes {
            moreDesBtn.isHidden = true
        }else {
            let maxHeight = 60 as CGFloat
            if height > maxHeight{
                height = maxHeight
                moreDesBtn.isHidden = false
                moreDesBtn.frame = CGRect.init(x: cycleDes.right-60, y: cycleDes.top+height-34, width: 60, height: 30)
                moreDesBtn.setTitle(Rstring.cycle_des_more.localized(), for: .normal)
            }
        }
        
        cycleDes.height = height;
        lineView.top = cycleDes.bottom;
        cycleMember.top = cycleDes.bottom
        let arr = [UserModel]()
        cycleMember.updateViews(arr)
        
        headView.height = cycleMember.bottom
        tableView.tableHeaderView = headView
    }
    
    @IBAction func onMoreDesAction() {
        showMoreDes = true
        updateHeaderView()
    }
    
    @IBAction func onChangeImageAction() {
//        PohtoManage.shared.choosePicture(self, editor: true) { (image) in
//            self.cycleImage.image = image
//        }
    }
}
// MARK: data  TOTO:

extension CycleIndexPage {
    
    func loadGroupInfo(){
        guard !cycleModel.DNA.isEmpty else {  return }
        self.tempTimestamp = Utility.currentTimeStamp()
        
        let hud = self.hudLoading(Rstring.common_LOAD.localized())
        
        GroupApi.groupInfo(dna: cycleModel.DNA, suc: { (model) in
            self.cycleModel = model
            
            let articles = model.GroupArticles!
            for item in articles{
                self.contentList.append(item)
            }
            self.tableView.reloadData()
            
            hud.hide(animated: true)
            self.tableView.endMJRefresh()
            self.tempOffset += 1
            self.updateEmptyView()
            self.updateHeaderView()
            self.updateCreateBtn()
            if articles.count < articles_page_size {
                self.tableView.noMoreData()
            }
        }) { (error) in
            hud.hide(animated: true)
            debugPrint(error)
            self.hudShow(error.localizedDescription)
        }
    }
    
    // load data
    func loadData(start: String, offset:Int)  {
        
        guard !cycleModel.DNA.isEmpty else {  return }
        
        let hud = self.hudLoading(Rstring.common_LOAD.localized())
        let address = UserTool.shared.userAddress()
        
        GroupApi.groupArticles(
            dna: cycleModel.DNA,
            UserAddress: address,
            Start: start,
            Offset: String(offset),
            suc: { (articles) in
                
                if offset == request_start_offset {
                    self.contentList.removeAll()
                }
                for item in articles{
                    self.contentList.append(item)
                }
                
                self.tableView.reloadData()
                hud.hide(animated: true)
                self.tableView.endMJRefresh()
                self.tempOffset += articles.count
                self.updateEmptyView()
                if articles.count < articles_page_size {
                    self.tableView.noMoreData()
                }
        }) { (error) in
            debugPrint(error)
            hud.hide(animated: true)
            self.tableView.endMJRefresh()
            self.hudShow(error.localizedDescription)
            self.updateEmptyView()
        }
    }
    
    func updateEmptyView() {
        if self.contentList.count == 0 {
            self.tableView.tableFooterView = self.emptyView
        }else {
            self.tableView.tableFooterView = nil
        }
    }
    
    // 0加入 1退出  2关注 3取消关注
    func handelGroup(type: Int) {
        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.costValue = JOIN_CIRCLE_PST
        //vc.pstTitle.text = "5PST"
        //vc.lockLabel.text = Rstring.cycle_create_lock.localized()
        vc.pwdBlock = { [weak self] (pwd) in
            switch type {
            case 0:
                self?.joinGroup(pwd: pwd)
                break
            case 1:
                self?.exitGroup(pwd: pwd)
                break
            case 2:
                self?.followGroup(pwd: pwd)
                break
            case 3:
                self?.unfollowGroup(pwd: pwd)
                break
            default:
                break
                
            }
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)
    }
    
    //加入社群
    func joinGroup(pwd: String){
        _ = self.hudLoading("")
        GroupApi.joinGroup(passphrase: pwd, dna: cycleModel.DNA, suc: { (res) in
            self.cycleModel.TxStatus = res.TxStatus
            self.updateCreateBtn()
            self.hudHide()
            self.hudShow(Rstring.join_circle_tip.localized(), afterDelay: 2)
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            if IS_PwdError(error) {
                Utility.delay(0.5, closure: {
                    self.pwdErrorAlert {  self.handelGroup(type: 0) }
                })
            } else {
                self.hudShow(error.localizedDescription)
            }
        }
    }
    
    //退出社群
    func exitGroup(pwd: String){
       _ = self.hudLoading("")
        GroupApi.exitGroup(passphrase: pwd, dna: cycleModel.DNA, suc: { (res) in
            self.cycleModel.TxStatus = res.TxStatus
            self.updateCreateBtn()
            self.hudHide()
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            self.hudShow(error.localizedDescription)
        }
    }
    
    
    //关注社群
    func followGroup(pwd: String){
        _ = self.hudLoading("")
        GroupApi.exitGroup(passphrase: pwd, dna: cycleModel.DNA, suc: { (res) in
            self.cycleModel.follow_state = 1
            self.updateFollowBtn()
            self.hudHide()
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            self.hudShow(error.localizedDescription)
        }
    }
    
    //取消关注社群
    func unfollowGroup(pwd: String){
        _ = self.hudLoading("")
        GroupApi.exitGroup(passphrase: pwd, dna: cycleModel.DNA, suc: { (res) in
            self.cycleModel.follow_state = 0
            self.updateFollowBtn()
            self.hudHide()
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            self.hudShow(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension CycleIndexPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ImageTextCell = tableView.dequeueReusableCell(withIdentifier: Rnib.imageTextCell.identifier, for: indexPath) as! ImageTextCell
        if !self.contentList.isEmpty {
            let model = contentList[indexPath.section]
            cell.setModel(articleModel: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.contentList.isEmpty {
            let model = contentList[indexPath.section]
            return ImageTextCell.getCellHeight(articleModel: model)
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !self.contentList.isEmpty {
            let model = contentList[indexPath.section]
            let vc = Rstoryboard.homePage.articleDetail()
            vc?.dna = model.DNA!
            vc?.GroupDNA = cycleModel.DNA!
            pushVc(vc!)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 15))
        view.backgroundColor = Color_fafafa
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ARTICLE_FOOT_HEIGHT
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navBarView.customAlpha = (scrollView.contentOffset.y - headView.height) / 50.0
    }
}

