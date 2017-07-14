//
//  TestViewController.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

// Just for test something...
class TestViewController: UIViewController {
    let testView = TestView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "测试专供"

        // self.view.backgroundColor = UIColor.yellow
        // let subView = TestSubViewController()
        // subView.modalTransitionStyle = .crossDissolve
        // subView.modalPresentationStyle = .overCurrentContext
        // present(subView, animated: true)

        let segment = SegmentView(style: .single)
        segment.currentActive = .left
        segment.normalColor = UIColor.yellow
        segment.bind(leftTitle: "中国玩大了", rightTitle: "先锋队员", "222", "555")
        segment.bind(leftTitle: "中国玩22大了", rightTitle: "先锋s队员", "2212", "555")


        // segment.backgroundColor = UIColor.yellow
        self.view.addSubview(segment)
        
        segment.snp.makeConstraints {
            make in
            make.left.right.bottom.equalTo(self.view)
            make.size.height.equalTo(50)
        }
        

    }
    
    func test() {
        print("test")
//        dismiss(animated: true, completion: nil)
    }

}

// Mark - UITableViewDatasoource, UITableViewDelegate

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "wang"
        return cell
    }
}


