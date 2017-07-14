//
//  GroupViewController.swift
//  Primas
//
//  Created by 甘露 on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var groupView: GroupView? = nil
    
    let groups = [
        [
            "title": "第一个小组",
            "image": "",
            "count": 20
        ],
        [
            "title": "第一个小组",
            "image": "",
            "count": 35
        ],
        [
            "title": "第一个小组",
            "image": "",
            "count": 10
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView = GroupView(frame: .zero)
        groupView?.collectionViewDataSource = self
        groupView?.collectionViewDelegate = self
        
        self.view.addSubview(groupView!)
        
        groupView!.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.toolbarItems = self.navigationController?.toolbar.items
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupViewCollectionCell.identifier, for: indexPath)
        return cell
    }
}
