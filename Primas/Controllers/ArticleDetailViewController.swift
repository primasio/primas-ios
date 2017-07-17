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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load view 
        articleView = ArticleDetailView()
        articleView.setup()

        // bind model to view
        let model = ArticleDetailModel.generateTestData()
        articleView.bind(model)

        self.view.addSubview(articleView)
        self.view.backgroundColor = UIColor.white

        self.toolbarItems = toolbar.getItems()

        articleView.snp.makeConstraints {
            make in
            make.top.equalTo(self.view)
            make.left.bottom.equalTo(self.view).offset(SIDE_MARGIN)
            make.right.bottom.equalTo(self.view).offset(-SIDE_MARGIN)
        }

       articleView.bindInfringement(title: "鲁迅 \"人们币在越南可以花多久！现金汇率？\"")

       articleView.bindGroup(imageUrl: "https://ps.ssl.qhimg.com/t01323fc0361c7ad6c7.jpg", name: "无人时代", contentNumber: 5468, peopleNumber: 5869)

       initShare()
       initTransfer()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "文章详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: primasFont(15)]
        self.navigationController?.navigationBar.tintColor = PrimasColor.shared.main.main_font_color
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: PrimasColor.shared.main.light_font_color)
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
        toolbar.rights.customView?.isUserInteractionEnabled = true
        toolbar.rights.customView?.addGestureRecognizer(tap)
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

