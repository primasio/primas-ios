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

    var infringement: Bool = true
    var infringmentView: UIView?
    var leftBarButtonItem: UIBarButtonItem?
   
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

        
        
        let toolbar = ArticleDetailToolBar()
        self.toolbarItems = toolbar.getItems()

        if infringement {
            addInfringementView()
            
            articleView.snp.makeConstraints {
                make in
                make.top.equalTo(infringmentView!.snp.bottom).offset(25)
                make.left.bottom.equalTo(self.view).offset(SIDE_MARGIN)
                make.right.bottom.equalTo(self.view).offset(-SIDE_MARGIN)
            }
        } else {
            articleView.snp.makeConstraints {
                make in
                make.left.top.equalTo(self.view).offset(SIDE_MARGIN)
                make.right.bottom.equalTo(self.view).offset(-SIDE_MARGIN)
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, SIDE_MARGIN, 25, SIDE_MARGIN))
            }
        }
    }

    func addInfringementView(_ title: String = "鲁迅「人民币在越南可以花多久！现金汇率？") {
        let _view = UIView()
        let _icon = UILabel()
        let _tip = UILabel()
        let _title = UILabel()

        _tip.text = "该内容疑似侵权"
        _tip.font = primasFont(14)
        _tip.textColor = PrimasColor.shared.main.red_font_color

        _icon.text = Iconfont.at.rawValue
        _icon.textColor = PrimasColor.shared.main.red_font_color
        _icon.font = UIFont.iconfont(ofSize: 14)

        _title.font = primasFont(13)
        _title.textColor = PrimasColor.shared.main.sub_font_color
        _title.text = "原文: " + title

        _view.addSubview(_icon)
        _view.addSubview(_tip)
        _view.addSubview(_title)
        _view.layer.borderWidth = 1.0
        _view.layer.borderColor = PrimasColor.shared.main.red_font_color.cgColor
        _view.layer.cornerRadius = 4.0

        self.view.addSubview(_view)

        _view.snp.makeConstraints {
            make in 
            make.left.top.equalTo(self.view).offset(SIDE_MARGIN)
            make.right.equalTo(self.view).offset(-SIDE_MARGIN)
            make.size.height.equalTo(70)
        }

        _icon.snp.makeConstraints {
            make in 
            make.left.equalTo(_view).offset(SIDE_MARGIN)
            make.top.equalTo(_view).offset(14)
        }

        _tip.snp.makeConstraints {
            make in 
            make.left.equalTo(_icon.snp.right).offset(5)
            make.top.equalTo(_icon)
        }

        _title.snp.makeConstraints {
            make in 
            make.left.equalTo(_icon)
            make.top.equalTo(_icon.snp.bottom).offset(14)
            make.right.equalTo(_view).offset(-SIDE_MARGIN)
        }
        
        _view.backgroundColor = PrimasColor.shared.main.infringement_background_color
        infringmentView = _view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "文章详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: primasFont(15)]
        self.navigationController?.navigationBar.tintColor = PrimasColor.shared.main.main_font_color
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func backToView() {
        navigationController?.popViewController(animated: true)
    }
}
