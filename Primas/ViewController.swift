//
//  ViewController.swift
//  Primas
//
//  Created by wang on 03/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var homeView: HomeView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView()
        
        view.addSubview(homeView)
        
        homeView.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(self.view);
        }
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        // self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

