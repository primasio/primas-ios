//
//  HomeView.swift
//  Primas
//
//  Created by wang on 05/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import Foundation
import SwiftIconFont

class HomeView: UIView {
    let logoSection: UIView = {
        let _view = UIView(frame: UIApplication.shared.statusBarFrame)
        let _logo = UIImageView(image: UIImage(named: "logo.png"))
        let _search = UISearchBar()
        

        _view.addSubview(_logo)
        _view.addSubview(_search)
        
        _search.tintColor = PrimasColor.shared.main.main_font_color
        _search.searchBarStyle = .minimal
        _search.placeholder = "铸钢大桥今日开通"

        _logo.snp.makeConstraints {
            make in 
            make.left.equalTo(_view)
            make.centerY.equalTo(_view)
            make.size.equalTo(CGSize(width: 88, height: 15))
        }

        _search.snp.makeConstraints {
            make in 
            make.left.equalTo(_logo.snp.right).offset(15)
            make.centerY.equalTo(_view)
            make.right.equalTo(_view)
        }
        
       
        return _view
    }()

    let bottomLine: UIView = {
        return ViewTool.generateLine(PrimasColor.shared.main.line_background_color)
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(HomeListCell.self, forCellReuseIdentifier: HomeListCell.registerIdentifier)
        tableView.separatorStyle = .none
        
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.white

        self.addSubview(logoSection)
        self.addSubview(bottomLine)
        self.addSubview(tableView)

        logoSection.snp.makeConstraints {
            make in 
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
            make.top.equalTo(self).offset(22)
            make.size.height.equalTo(36)
        }

        bottomLine.snp.makeConstraints {
            make in 
            make.top.equalTo(logoSection.snp.bottom)
            make.left.right.equalTo(self)
        }

        tableView.backgroundColor = PrimasColor.shared.main.main_background_color
        tableView.snp.makeConstraints {
            make in 
            make.left.right.equalTo(self)
            make.top.equalTo(logoSection.snp.bottom).offset(1)
            make.bottom.equalTo(self).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
