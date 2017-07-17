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
    let subView = TestSubViewController()
    var modalComponent: ModalViewComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.isTranslucent = true
        setup()
    }
    
    func setup() {
        self.title = "测试专供"

        self.view.backgroundColor = UIColor.white
        // subView.modalTransitionStyle = .coverVertical
        // subView.modalPresentationStyle = .overCurrentContext
        // present(subView, animated: true, completion: nil)
        // let tap = UITapGestureRecognizer(target: self, action: #selector(test))
        // tap.numberOfTapsRequired = 1
        // subView.testView.testLabel.isUserInteractionEnabled = true
        // subView.testView.testLabel.addGestureRecognizer(tap)
        
//        let image = UIImageView(image: UIImage(named: "profile-bg"))
        
        self.modalComponent = ModalViewComponent(subView: testView, height: 512)
        app().window?.addSubview(modalComponent!)
        
         let seeTap = UITapGestureRecognizer(target: self, action: #selector(see))
         seeTap.numberOfTapsRequired = 1
         self.view.addGestureRecognizer(seeTap)
    }
    
    func test() {
        dismiss(animated: true, completion: nil)
    }
    
    func see() {
//        present(subView, animated: true, completion: nil)
        modalComponent?.show()
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


