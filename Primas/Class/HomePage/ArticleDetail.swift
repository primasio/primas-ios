//
//  ArticleDetal.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

enum articleInfo_display {
    case article_detail
    case transmit_article
    case post_finish
}

// MARK: - Selector
extension Selector {
    static let postArticleClose = #selector(ArticleDetail.postArticleCloseAction)
}

class ArticleDetail: BaseViewController {

    fileprivate var ARITICLE_SECTION_COUNT = 7
    fileprivate let MAX_COMMENT = 5
    fileprivate var goComment = false

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    fileprivate lazy var comments: [CommentModel] = {
        return []
    }()
    fileprivate lazy var noComments: NocomentPage = {
        let view = Rnib.nocomentPage.firstView(owner: nil)!
        view.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 200)
        return view
    }()
    
    lazy var transmitButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Color_ED5634
        button.addTarget(self,
                         action: #selector(transmitAction),
                         for: .touchUpInside)
        button.setTitle(Rstring.post_to_circle.localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    
    var dna = ""
    var GroupDNA = ""
    var circleModel =  CycleModel()
    
    fileprivate var model: ArticelModel?
    var display: articleInfo_display = .article_detail

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView
        tableView.register(Rnib.commentCell)
        
        // modify button
        let edge = UIEdgeInsets.init(
            top: 0, left: -10,
            bottom: 0, right: 0)
        
        likeBtn.imageEdgeInsets = edge
        commentBtn.imageEdgeInsets = edge
        shareBtn.imageEdgeInsets = edge
        bottomView.isHidden = true
        
        // request
         resuqestByDNA(dna: dna, groupDNA: GroupDNA)
        
        // finish post article
        if display == .post_finish {
            let close = UIBarButtonItem.init(
                image: Rimage.guanbi()?.original(),
                style: .plain,
                target: self,
                action: .postArticleClose)
            self.navigationItem.leftBarButtonItem = close
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    // request DNA
    func resuqestByDNA(dna: String, groupDNA: String)  {
        guard !dna.isEmpty else { return }
        
        // request ArticleMetadata
        let hud = self.hudLoading(Rstring.common_LOAD.localized())

        var articleContent = ""
        var flag1 = false
        var flag2 = false
        var flag3 = false
        var flag4 = false

        let group = DispatchGroup()
        group.enter()
        ArticleAPI.getArticleMetadata(
            dna: dna,
            suc: { article in
                flag1 = true
                self.model = article
                group.leave()
        }) { (error) in
            self.hudShow(error.localizedDescription)
            debugPrint(error)
            group.leave()
        }
        // request Article content
        group.enter()
        ArticleAPI.readArticle(dna: dna, suc: { content in
            if !content.isEmpty {
                articleContent = String(content.dropLast())
                articleContent = String(articleContent.dropFirst())
                articleContent = articleContent.replaceReturn()
            }
            group.leave()
            flag2 = true
        }, err: { (error) in
            self.hudShow(error.localizedDescription)
            debugPrint(error)
            group.leave()
        })
        
        // group info
        if groupDNA.isEmpty {
            flag3 = true
            flag4 = true
        } else {
            group.enter()
            GroupApi.groupInfo(
                dna: groupDNA,
                suc: { (model) in
                    self.circleModel = model
                    group.leave()
                    flag3 = true
            }) { (error) in
                self.hudShow(error.localizedDescription)
                debugPrint(error)
                group.leave()
            }
            
            group.enter()
            ArticleAPI.getComment(
                dna: dna,
                Start: Utility.currentTimeStamp(),
                Offset: request_start_offset,
                suc: { models in
                    self.comments = models
                    if self.comments.count >= self.MAX_COMMENT {
                        self.ARITICLE_SECTION_COUNT = self.ARITICLE_SECTION_COUNT + 1
                    }
                    flag4 = true
                    group.leave()
            }) { (error) in
                self.hudShow(error.localizedDescription)
                debugPrint(error)
                group.leave()
            }
            
        }
        
        group.notify(queue: DispatchQueue.main) {
            hud.hide(animated: true)
            if flag1 && flag2 && flag3 && flag4 {
                self.model?.Content = articleContent
                self.handleOtherData()
                self.tableView.reloadData()
                self.congigureBottom()
            }
        }
    }
    
    // MARK: - set bottom view
    func congigureBottom()  {
        if display == .transmit_article || display == .post_finish  {
            ARITICLE_SECTION_COUNT = 5
            transmitButton.frame = bottomView.bounds
            bottomView.addSubview(transmitButton)
            if model?.TxStatus == "1" {
                commentBtn.isEnabled = false
                shareBtn.isEnabled = false
                likeBtn.isEnabled = false
                transmitButton.setTitle(Rstring.post_to_auditting.localized(), for: .normal)
                transmitButton.backgroundColor = UIColor.gray
                transmitButton.isEnabled = false
            }
        } else {
            if self.comments.isEmpty {
                self.tableView.tableFooterView = self.noComments
            }
        }
        self.bottomView.isHidden = false
    }
    
    // footer data
    func handleOtherData()  {
        self.likeBtn.setTitle(model?.LikeCount, for: .normal)
        self.commentBtn.setTitle(model?.CommentCount, for: .normal)
        self.shareBtn.setTitle(model?.ShareCount, for: .normal)
    }
    
    // 发布到圈子
    @objc func transmitAction()  {
        let vc = Rstoryboard.postPage.postToCircle()
        vc?.articleDNA = (self.model?.DNA)!
        self.pushVc(vc!)
    }
    // close post article page
    @objc func postArticleCloseAction()  {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        X_Notification.post(GET_Notification(.end_post_article))
    }
    // formated tags
    func formateTags(_ extra: String) -> [String] {
        var result:[String] = []
        if !extra.isEmpty && extra != "{}" {
            result = (model?.Extra?.components(separatedBy: ","))!
        }
        return result
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav(false)
    }
    
    func judgeCanOperate(_ handle: @escaping (_ flag : Bool) -> ()) {
        GroupApi.groupInfo(
            dna: GroupDNA,
            suc: { (model) in
                var result = false
                if model.IsMember == nil {
                    result = false
                } else {
                    if model.IsMember!.TxStatus == "1" {
                        result = false
                    } else if model.IsMember!.TxStatus == "2" {
                        result = true
                    } else {
                        result = false
                    }
                }
                handle(result)
        }) { (error) in
            self.hudShow(error.localizedDescription)
            debugPrint(error)
             handle(false)
        }
    }
    
    func joinCircleAlert() {
        enoughBalance(usePst: JOIN_CIRCLE_PST) { (flag) in
            if flag {
                self.alertShow(
                    title: Rstring.need_join_circle.localized(),
                    message: nil,
                    cancelHandler: nil,
                    comfirmTitle: Rstring.confirm_BUTTON.localized()) { (_) in
                        self.joinPwdAlert()
                }
            } else {
                self.presentNoPST(disPlay: .join_circle)
            }
        }

    }
    
    func joinPwdAlert() {
        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.costValue = "2"
        vc.display = .usePst
        vc.pwdBlock = {  (pwd) in
            self.joinGroup(pwd: pwd)
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)
    }
    
    func joinGroup(pwd: String){
        _ = self.hudLoading("")
        GroupApi.joinGroup(passphrase: pwd, dna: circleModel.DNA, suc: { (res) in
            self.hudHide()
            self.hudShow(Rstring.article_join_circle.localized(), afterDelay: 2)
        }) { (error) in
            debugPrint(error)
            self.hudHide()
            if IS_PwdError(error) {
                Utility.delay(0.5, closure: {
                    self.pwdErrorAlert {  self.joinPwdAlert() }
                })
            } else {
                self.hudShow(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Outlet action
    @IBAction func likeAction(_ sender: Any) {
        if likeBtn.isSelected {
            hudShow(Rstring.notice_liked.localized())
        } else {
            self.judgeCanOperate({ (flag) in
                if flag {
                    self.likeThisArticle()
                } else {
                    self.joinCircleAlert()
                }
            })
        }
    }
    @IBAction func comemnt(_ sender: Any) {
        guard !goComment else { return }
        goComment = true
        self.judgeCanOperate({ (flag) in
            if flag {
                let vc = Rstoryboard.homePage.commentPage()!
                vc.dna = self.dna
                vc.GroupDNA = self.GroupDNA
                self.pushVc(vc)
            } else {
                self.joinCircleAlert()
            }
            self.goComment = false
        })

    }
    @IBAction func shareAction(_ sender: Any) {
        self.judgeCanOperate({ (flag) in
            if flag {
                let vc = Rstoryboard.postPage.postToCircle()
                vc?.articleDNA = (self.model?.DNA)!
                self.pushVc(vc!)
            } else {
                self.joinCircleAlert()
            }
        })
    }
    
    // MARK: - like this article
    func likeThisArticle()  {
        
        guard !self.GroupDNA.isEmpty else { return }
        
        let vc = Rstoryboard.noticeView.alertPassword()!
        vc.modalPresentationStyle = .overCurrentContext
        vc.block = { [weak vc] pwd in
            // likers
            ArticleAPI.likes(
                passphrase: pwd,
                dna: (self.model?.DNA)!,
                GroupDNA: self.GroupDNA,
                suc: {
                    vc?.checkPassword(flag: true)
                    self.hudShow(Rstring.notice_like_success.localized())
                    self.likeBtn.isSelected = true
                    var likeCount = Int((self.model?.LikeCount)!)
                    likeCount = 1 + likeCount!
                    self.likeBtn.setTitle("\(likeCount!)", for: .normal)
            }, err: { (error) in
                if IS_PwdError(error) {
                    vc?.checkPassword(flag: false)
                } else {
                    vc?.checkPassword(flag: true)
                    self.hudShow(GethErrorLog(error))
                }
                debugPrint(error)
            })
        }
        presentVc(vc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension ArticleDetail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 6 {
            return self.comments.count >= self.MAX_COMMENT ? self.MAX_COMMENT : self.comments.count
        }
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return ARITICLE_SECTION_COUNT
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if model == nil { return UITableViewCell() }

        if display == .article_detail {
        if indexPath.section == 0 {
            let cell:DetailPageCircle = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.detailPageCircle, for: indexPath)!
                cell.setData(circle: circleModel)
                cell.setValue(str: (model?.TotalIncentives)!)
            return cell
        } else  if indexPath.section == 1 {
            let cell:ArticleTitleCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.articleTitleCell, for: indexPath)!
            cell.contentTitle.text = model?.Title
            return cell
        } else  if indexPath.section == 2 {
            let cell:AuthorInfoCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.authorInfoCell, for: indexPath)!
            cell.authorName.text = model?.Author?.Name == "" ? "unknow" : model?.Author?.Name
            cell.timeLabel.text = model?.CreatedAt?.toTimeString()
            let dtcp =  model?.DNA?.substring(from: 0, to: 8)
            cell.circleBtn.setTitle( "  " + dtcp! + "  ", for: .normal)
            cell.dtcpAction = {
                let vc = ArticleInfo()
                vc.setData(model: self.model!)
                self.pushVc(vc)
            }
            return cell
        }  else  if indexPath.section == 3 {
            let cell:ArticleContent = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.articleContent, for: indexPath)!
            cell.setContent(content: (model?.Content)!)
            return cell
        } else  if indexPath.section == 4 {
            let cell:TagTableViewCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.tagTableViewCell, for: indexPath)!
            let tags:[String] = self.formateTags((model?.Extra)!)
            cell.setTagsData(tags:tags)
            return cell
        } else  if indexPath.section == 5 {
            let cell:CommentHeader = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.commentHeader, for: indexPath)!
            cell.commentNum.text = "(" + "\(comments.count)" + ")"
            return cell
        } else  if indexPath.section == 6 {
            let cell:CommentCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.commentCell, for: indexPath)!
            if !comments.isEmpty {
                cell.setData(comments[indexPath.row])
            }
            return cell
        } else  if indexPath.section == 7 {
            let cell:CommentFooter = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.commentFooter, for: indexPath)!
            return cell
            }
        } else {
            if indexPath.section == 0 {
                let cell:ArticleTitleCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.articleTitleCell, for: indexPath)!
                    cell.contentTitle.text = model?.Title
                return cell
            } else  if indexPath.section == 1 {
                let cell:AuthorInfoCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.authorInfoCell, for: indexPath)!
                    cell.authorName.text = model?.Author?.Name == "" ? "unknow" : model?.Author?.Name
                    cell.timeLabel.text = model?.CreatedAt?.toTimeString()
                    let dtcp = model?.DNA?.substring(from: 0, to: 8)
                    cell.circleBtn.setTitle("  " + dtcp! + "  ", for: .normal)
                cell.dtcpAction = {
                    let vc = ArticleInfo()
                    vc.setData(model: self.model!)
                    self.pushVc(vc)
                }
                return cell
            }  else  if indexPath.section == 2 {
                let cell:ArticleContent = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.articleContent, for: indexPath)!
                    cell.setContent(content: (model?.Content)!)
                return cell
            } else  if indexPath.section == 3 {
                let cell:TagTableViewCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.tagTableViewCell, for: indexPath)!
                let tags:[String] = self.formateTags((model?.Extra)!)
                    cell.setTagsData(tags:tags)
                return cell
            }
        }
        
        /// Just for return
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if model == nil { return 0 }

        if display == .article_detail {
            if indexPath.section == 0 {
                return DetailPageCircle.cellHeight(circle: circleModel)
            } else if indexPath.section == 1 {
                return ArticleTitleCell.cellHeight(content: (model?.Title)!)
            } else if indexPath.section == 2 {
                return AuthorInfoCell.cellHeight()
            } else if indexPath.section == 3 {
                return ArticleContent.cellHeight(content: (model?.Content)!)
            } else if indexPath.section == 4 {
                let tags:[String] = self.formateTags((model?.Extra)!)
                return TagTableViewCell.cellHeight(count: tags.count)
            } else if indexPath.section == 5 {
                return CommentHeader.cellHeight()
            } else if indexPath.section == 6 {
                if self.comments.isEmpty { return 0 }
                return CommentCell.cellHeight(comments[indexPath.row])
            } else if indexPath.section == 7 {
                return CommentFooter.cellHeight()
            }
        } else {
            
            if indexPath.section == 0 {
                return ArticleTitleCell.cellHeight(content: (model?.Title)!)
            } else if indexPath.section == 1 {
                return AuthorInfoCell.cellHeight()
            } else if indexPath.section == 2 {
                return ArticleContent.cellHeight(content: (model?.Content)!)
            } else if indexPath.section == 3 {
                let tags:[String] = self.formateTags((model?.Extra)!)
                return TagTableViewCell.cellHeight(count: tags.count)
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        if display == .article_detail {
            if indexPath.section == 7 {
                let vc = Rstoryboard.homePage.commentPage()!
                vc.dna = dna
                pushVc(vc)
            }
        }
    }
}
