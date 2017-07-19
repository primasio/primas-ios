//
//  ArticleDetailViewController.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import UIKit
import SnapKit
import Kingfisher
import Foundation

class ArticleDetailViewController: UIViewController {
    var articleView: ArticleDetailView!
    var leftBarButtonItem: UIBarButtonItem?
    var shareView: UIImageView = UIImageView(image: UIImage(named: "modal-share"))
    var toolbar: ArticleDetailToolBar = ArticleDetailToolBar()
    var transferView: UIImageView = UIImageView(image: UIImage(named: "modal-transfer"))
    var scroll = UIScrollView(frame: CGRect(x:0, y:0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    var isInfringement: Bool = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.isScrollEnabled = true
        scroll.isUserInteractionEnabled = true
        scroll.showsVerticalScrollIndicator = true
        self.view.addSubview(scroll)
        

    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "文章详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: primasFont(15)]
        self.navigationController?.navigationBar.tintColor = PrimasColor.shared.main.main_font_color
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.toolbar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: PrimasColor.shared.main.light_font_color)
        
        articleView = ArticleDetailView(frame: CGRect(x: SIDE_MARGIN, y: SIDE_MARGIN, width: SCREEN_WIDTH - SIDE_MARGIN - SIDE_MARGIN, height: SCREEN_HEIGHT))
        articleView.backgroundColor = .white
        articleView.setup()

        let articleId = app().client.selectedArticleId
        let article = app().client.getArticleById(articleId)
        // bind model to view
        let model = ArticleDetailModel(title: (article?.title)!, content: (article?.content)!, username: (article?.author.name)!, userImageUrl: app().client.baseURL + (article?.author.avatar)!, createdAt: (article?.createdAt)!, shared: (article?.statistics.share)!, transfered: (article?.statistics.reproduction)!, stared: (article?.statistics.like)!, DNA: (article?.dna)!)
        articleView.bind(model)
        
        self.view.backgroundColor = UIColor.white
        
        self.toolbarItems = toolbar.getItems()
        
        
        scroll.addSubview(articleView)
        scroll.bringSubview(toFront: articleView)
        scroll.setContentOffset(.zero , animated: false)
        
        initShare()
        initTransfer()
        
        scroll.contentSize = CGSize(width: SCREEN_WIDTH,height: 2000.0)

        
        
        if !(article?.source.licensed)! {
            articleView.bindInfringement(title: (article?.source.title)!)
            self.navigationController?.setToolbarHidden(true, animated: false)
        } else {
            let _group = app().client.getGroupById((article?.groupId)!)
            articleView.bindGroup(imageUrl: app().client.baseURL + (_group?.image)!, name: (_group?.name)!, contentNumber: (_group?.contentTotal)!, peopleNumber: (_group?.memberTotal)!)
        }
        
    }

    func initShare() {
        shareView.backgroundColor = UIColor.green
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareTaped))
        tap.numberOfTapsRequired = 1
        toolbar.share.customView?.isUserInteractionEnabled = true
        toolbar.share.customView?.addGestureRecognizer(tap)
    }

    func initTransfer() {
        transferView.backgroundColor = UIColor.red
        let tap = UITapGestureRecognizer(target: self, action: #selector(transferTaped))
        tap.numberOfTapsRequired = 1
        toolbar.transfer.customView?.isUserInteractionEnabled = true
        toolbar.transfer.customView?.addGestureRecognizer(tap)
    }

    func shareTaped() {
        app().modal.reload(subView: self.shareView, height: 412)
        app().modal.show()
    }

    func transferTaped() {
        app().modal.reload(subView: self.transferView, height: 512)
        app().modal.show()
    }
}
