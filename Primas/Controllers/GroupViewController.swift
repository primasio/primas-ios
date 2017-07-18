//
//  GroupViewController.swift
//  Primas
//
//  Created by 甘露 on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var groupView: GroupView?
    
    var groups = [
        [
            "name": "天才实验室",
            "image": "group1",
            "totalContent": 20,
            "totalPeople": 100,
            "newContent": 10
        ],
        [
            "name": "无人时代",
            "image": "group2",
            "totalContent": 40,
            "totalPeople": 120,
            "newContent": 20
        ],
        [
            "name": "日式漫游",
            "image": "group3",
            "totalContent": 30,
            "totalPeople": 200,
            "newContent": 10
        ],
        [
            "name": "蒙德里安",
            "image": "group4",
            "totalContent": 2033,
            "totalPeople": 105,
            "newContent": 5
        ],
        [
            "name": "区块链世界",
            "image": "group5",
            "totalContent": 2022,
            "totalPeople": 80,
            "newContent": 80
        ],
        [
            "name": "每日书单",
            "image": "group6",
            "totalContent": 203,
            "totalPeople": 10,
            "newContent": 30
        ],
        [
            "name": "穷游世界",
            "image": "group7",
            "totalContent": 200,
            "totalPeople": 20,
            "newContent": 20
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView = GroupView(frame: .zero, dataSource: self, delegate: self)
        
        self.view.addSubview(groupView!)
        
        groupView!.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view)
        }

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = ViewTool.generateNavigationBarItem(Iconfont.search, PrimasColor.shared.main.main_font_color)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "社群"
        self.toolbarItems = self.navigationController?.toolbar.items
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isTranslucent = false

        self.groups = app().client.data?["groups"] as! Array<[String: Any]>
        app().toolbar.current = .group
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupViewCollectionCell.identifier, for: indexPath) as! GroupViewCollectionCell
        
        cell.setItem(item: groups[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 2
        return CGSize(width: width, height: width + 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
