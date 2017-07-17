//
//  EditorViewController.swift
//  Primas
//
//  Created by wang on 14/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class EditorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = ViewTool.generateNavigationBarItem(Iconfont.closed, PrimasColor.shared.main.main_font_color, self, #selector(back))
        let button = UIBarButtonItem(title: "发布", style: .done, target: self, action: #selector(back))
        button.setTitleTextAttributes([NSForegroundColorAttributeName: PrimasColor.shared.main.red_font_color], for: .normal)
        self.navigationItem.rightBarButtonItem = button

        let title = UITextView()
        title.font = primasFont(18)
        title.placeholder = "请输入标题"
        title.placeholderColor = PrimasColor.shared.main.line_background_color
        
        self.view.addSubview(title)

        let line = ViewTool.generateDashLine(width: SCREEN_WIDTH - SIDE_MARGIN - SIDE_MARGIN, height: 0.5)
        self.view.addSubview(line)

        title.snp.makeConstraints {
            make in
            make.left.equalTo(self.view).offset(SIDE_MARGIN)
            make.right.equalTo(self.view).offset(-SIDE_MARGIN)
            make.top.equalTo(self.view).offset(SIDE_MARGIN)
            make.size.height.equalTo(30)
        }

        line.snp.makeConstraints {
            make in 
            make.left.right.equalTo(title)
            make.top.equalTo(title.snp.bottom).offset(SIDE_MARGIN)
        }
        
        
        let content = UITextView()
        content.font = primasFont(14)
        content.placeholder = "请输入正文"
        content.placeholderColor = PrimasColor.shared.main.line_background_color

        self.view.addSubview(content)

        content.snp.makeConstraints {
            make in 
            make.left.equalTo(self.view).offset(SIDE_MARGIN)
            make.right.equalTo(self.view).offset(-SIDE_MARGIN)
            make.bottom.equalTo(self.view)
            make.top.equalTo(line.snp.bottom).offset(SIDE_MARGIN)
        }

    }

    func back() {
        self.navigationController?.popViewController(animated: true)
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
        self.navigationController?.setToolbarHidden(true, animated: true)
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
