//
//  GroupViewController.swift
//  Primas
//
//  Created by 甘露 on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {
    
    var groupView: GroupView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView = GroupView(frame: .zero)
        
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
}
