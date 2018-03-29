//
//  PostStepTwo.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/20.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot

class PostStepTwo: BaseViewController {
    fileprivate let ADD_BUTTON =  " ➕ "
    fileprivate var tagsArray:Array<String> = []
    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var agreeMentLabel: UILabel!
    @IBOutlet weak var agressButton: UIButton!
    @IBOutlet weak var common_Tag: UILabel!
    @IBOutlet weak var agreeTitle: UILabel!
    @IBOutlet weak var collectionHieght: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav
        let rightBaritem = UIBarButtonItem.init(
            title: Rstring.common_Post.localized(),
            style: .plain,
            target: self,
            action: #selector(postAction))
        rightBaritem.tintColor = Rcolor.ed5634()
        self.navigationItem.rightBarButtonItem = rightBaritem
        self.navigationItem.title = Rstring.article_content_info.localized()
        
        // localized
        tagTitle.text = Rstring.common_tags.localized()
        common_Tag.text = Rstring.normal_use_tags.localized()
        agreeTitle.text = Rstring.article_format_agressment.localized()
        agressButton.setTitle(Rstring.article_change_agree.localized(), for: .normal)
        
        // collection view
        let flow = UICollectionViewFlowLayout.init()
        flow.minimumLineSpacing = tagsLineSpacing
        let width = (kScreenW - 30 * 3) / 3
        flow.itemSize = CGSize.init(width: width, height: tagsHeigt)
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.scrollDirection = .vertical
        collectionView.collectionViewLayout = flow
        collectionView.register(Rnib.tagCollectionCell)
        
        tagsArray.append("科技")
        tagsArray.append("比特币")
        tagsArray.append("时政")
        tagsArray.append("金融")
        tagsArray.append("互联网")
        tagsArray.append(ADD_BUTTON)
        
        getCollectionHeight(count: tagsArray.count)
        
        let string = Rstring.article_content_agree.localized()
        
        let redStyle = StringStyle(
            .color(Rcolor.ed5634()),
            .underline(.styleSingle, Rcolor.ed5634()))
        
        let grayStyle = StringStyle(
            .color(Rcolor.c999999()))
        
        let blackStyle = StringStyle(
            .color(Rcolor.c333333()),
             .font(UIFont.systemFont(ofSize: 12)))
        
        let common = StringStyle(
            .font(UIFont.systemFont(ofSize: 13)),
            .lineHeightMultiple(1.2),
            .color(Rcolor.c666666()) ,
            .xmlRules([
                .style("red", redStyle),
                .style("gray", grayStyle),
                .style("black", blackStyle)
                ])
        )
        
        agreeMentLabel.attributedText = string.styled(with: common)
    }
    
    // MARK: - Post action
    @objc func postAction()  {
        guard !PostArticle.shared.tags.isEmpty else {
            hudShow(Rstring.common_add_tags.localized())
            return
        }
        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.costValue = "20"
        vc.pwdBlock = { [weak self] (pwd) in
            self?.postArticleToServer(pwd: pwd)
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)
    }
    
    func postArticleToServer(pwd: String)  {
        let title = PostArticle.shared.title
        let content = PostArticle.shared.content
        let category = PostArticle.shared.tags.joined(separator: ",")
        
        ArticleAPI.postArticle(
            passphrase: pwd,
            title: title,
            content: content,
            license: "{}",
            extra: category,
            suc: { (acticle) in
                
                Utility.delay(0.5, closure: {
                    let v:NoticeArticleInfo = Rstoryboard.noticeView.noticeArticleInfo()!
                    debugPrint(acticle.BlockHash!)
                    debugPrint(acticle.DNA!)
                    v.articleAddress = acticle.BlockHash!
                    v.subContentText = acticle.DNA!.substring(from: 0, to: 8)
                    v.modalPresentationStyle = .overCurrentContext
                    v.finishBlock = {
                         self.goToArticlePage(acticle)
                    }
                    self.presentVc(v, animated: false)
                })
 
        }) { (error) in
            if IS_PwdError(error) {
                Utility.delay(0.5, closure: {
                    self.pwdErrorAlert {  self.postAction() }
                })
            } else {
                self.hudShow(error.localizedDescription)
            }
            debugPrint(error.localizedDescription)
        }
    }

    /// caculate collection height
    func getCollectionHeight(count: Int) {
        let singleH = tagsHeigt + tagsLineSpacing
        var num = 0
        num = count / 3
        if count % 3 > 0 {
            num = num + 1
        }
        collectionHieght.constant = singleH * CGFloat.init(num)
        self.view.updateConstraintsIfNeeded()
    }

    func goToArticlePage(_ acticle: ArticelModel) {
        let vc = Rstoryboard.homePage.articleDetail()!
        vc.display = .post_finish
        vc.dna = acticle.DNA!
        pushVc(vc)
    }
    
    // MARK: - Outlet action
    
    @IBAction func changeAgresment(_ sender: Any) {
        let v = Rstoryboard.postPage.agreementPage()!
        v.modalPresentationStyle = .overCurrentContext
        let nav = UINavigationController.init(rootViewController: v)
        self.presentVc(nav, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PostStepTwo: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell:TagCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RreuseIdentifier.tagCollectionCell, for: indexPath)!
        if !(tagsArray.isEmpty) {
            let content = tagsArray[indexPath.row]
            tagCell.contentLabel.text = content
            if content == ADD_BUTTON {
                tagCell.setTags(display: .show)
            } else {
                if PostArticle.shared.tags.contains(content) {
                    tagCell.setTags(display: .selected)
                } else {
                    tagCell.setTags(display: .select)
                }
            }
        }
        return tagCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !tagsArray.isEmpty {
            let content = tagsArray[indexPath.row]
            if content == ADD_BUTTON {
                let tagsVc = Rstoryboard.postPage.tagsPage()!
                let nav = GesturePopNav.init(rootViewController: tagsVc)
                tagsVc.tagsBlock = { tags in
                    debugPrint(tags)
                    for str in tags {
                        PostArticle.shared.addTags(tag: str as! String)
                    }
                    self.tagsArray.removeAll()
                    for tag in PostArticle.shared.tags {
                        self.tagsArray.append(tag)
                    }
                    self.tagsArray.append(self.ADD_BUTTON)
                    self.getCollectionHeight(count: self.tagsArray.count)
                    self.collectionView.reloadData()
                }
                presentVc(nav)
            } else {
                let cell:TagCollectionCell = collectionView.cellForItem(at: indexPath) as! TagCollectionCell
                if cell.display == .select {
                    cell.setTags(display: .selected)
                } else {
                    cell.setTags(display: .select)
                }
                PostArticle.shared.addTags(tag: content)
            }
        }
    }
}
