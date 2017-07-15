//
//  EditorViewController.swift
//  Primas
//
//  Created by wang on 14/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class EditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = ViewTool.generateNavigationBarItem(Iconfont.closed, PrimasColor.shared.main.main_font_color)
        let button = UIBarButtonItem(title: "发布", style: .done, target: nil, action: nil)
        button.setTitleTextAttributes([NSForegroundColorAttributeName: PrimasColor.shared.main.red_font_color], for: .normal)
        self.navigationItem.rightBarButtonItem = button

        let title = UITextView()
        title.font = primasFont(20)
        
        self.view.addSubview(title)
        
        title.snp.makeConstraints {
            make in
            make.left.top.right.equalTo(self.view)
            make.size.height.equalTo(30)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: primasFont(15)]
        self.navigationController?.navigationBar.tintColor = PrimasColor.shared.main.main_font_color
        self.navigationController?.navigationBar.topItem?.title = "";
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: PrimasColor.shared.main.light_font_color)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
