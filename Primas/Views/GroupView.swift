//
//  GroupView.swift
//  Primas
//
//  Created by 甘露 on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class GroupView: UIView {
    
    var collectionViewDataSource: UICollectionViewDataSource?
    var collectionViewDelegate: UICollectionViewDelegate?
    
    init(frame: CGRect, dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
        super.init(frame: frame)
        
        collectionViewDelegate = delegate
        collectionViewDataSource = dataSource
        
        setup()
    }
    
    func setup() {
        self.backgroundColor = UIColor.white
        
        let titleView = UIView()
    
        self.addSubview(titleView)
        
        let titleNameView = UIView()
        titleView.addSubview(titleNameView)
        
        
        let titleLabel = UILabel()
        titleLabel.text = "社群"
        titleLabel.textColor = UIColor.black
        
        titleNameView.addSubview(titleLabel)
        
        let navView = UIView()
        titleView.addSubview(navView)
        
        let navBorder = UIView()
        navBorder.backgroundColor = UIColor.lightGray
        navView.addSubview(navBorder)
        
        let navCollectionView = UIView()
        
        let navCollectionLabel = UILabel()
        navCollectionLabel.text = "内容精选"
        
        navCollectionView.addSubview(navCollectionLabel)
        
        let navGroupsView = UIView()
        
        let navGroupsLabel = UILabel()
        navGroupsLabel.text = "我的社群"
        navGroupsLabel.textColor = UIColor.red
        navGroupsView.addSubview(navGroupsLabel)
        
        let navItemBorder = UIView()
        navGroupsView.addSubview(navItemBorder)
        navItemBorder.backgroundColor = UIColor.red
        
        navView.addSubview(navCollectionView)
        navView.addSubview(navGroupsView)
        
        
        let groupLayout = UICollectionViewFlowLayout()
        groupLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        let groupCollection = UICollectionView.init(frame: self.frame, collectionViewLayout: groupLayout)
        groupCollection.register(GroupViewCollectionCell.self, forCellWithReuseIdentifier: GroupViewCollectionCell.identifier)
        groupCollection.dataSource = collectionViewDataSource
        groupCollection.delegate = collectionViewDelegate
        groupCollection.bounces = true
        groupCollection.alwaysBounceVertical = true
        groupCollection.backgroundColor = UIColor.white
        
        self.addSubview(groupCollection)
        
        titleView.snp.makeConstraints {
            make in
            make.top.left.right.equalTo(self)
            make.size.height.equalTo(134.0)
        }
        
        titleNameView.snp.makeConstraints {
            make in
            make.top.left.right.equalTo(titleView)
            make.size.height.equalTo(67.0)
        }
        
        titleLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(titleNameView)
            make.centerY.equalTo(titleNameView).offset(10)
        }
        
        navView.snp.makeConstraints {
            make in
            make.bottom.left.right.equalTo(titleView)
            make.size.height.equalTo(67.0)
        }
        
        navBorder.snp.makeConstraints {
            make in
            make.bottom.left.right.equalTo(navView)
            make.size.height.equalTo(1.0)
        }
        
        navCollectionView.snp.makeConstraints {
            make in
            make.top.bottom.left.equalTo(navView)
            make.width.equalTo(navView).multipliedBy(0.5)
        }
        
        navGroupsView.snp.makeConstraints {
            make in
            make.top.bottom.right.equalTo(navView)
            make.width.equalTo(navView).multipliedBy(0.5)
        }
        
        navGroupsLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(navGroupsView)
            make.centerY.equalTo(navGroupsView).offset(5)
        }
        
        navCollectionLabel.snp.makeConstraints {
            make in
            make.centerX.equalTo(navCollectionView)
            make.centerY.equalTo(navCollectionView).offset(5)
        }
        
        navItemBorder.snp.makeConstraints {
            make in
            make.bottom.left.right.equalTo(navGroupsView)
            make.size.height.equalTo(1.0)
        }
        
        groupCollection.snp.makeConstraints {
            make in
            make.top.equalTo(self).offset(134.0)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
