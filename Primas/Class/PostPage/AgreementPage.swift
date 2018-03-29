//
//  Agreement Page.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class AgreementPage: BaseViewController {

    @IBOutlet weak var agreeTitle1: UILabel!
    @IBOutlet weak var agreeTitle2: UILabel!
    @IBOutlet weak var agreeTitle3: UILabel!

    @IBOutlet weak var agressView1: UIView!
    @IBOutlet weak var agressView2: UIView!
    @IBOutlet weak var agressContent1: UILabel!
    @IBOutlet weak var agressContent2: UILabel!
    @IBOutlet weak var agressSelect1: UIImageView!
    @IBOutlet weak var agressSelect2: UIImageView!

    @IBOutlet weak var agressImageView: UIImageView!
    @IBOutlet weak var agressImageView2: UIImageView!
    
    @IBOutlet weak var checkBtn1: UIButton!
    @IBOutlet weak var checkBtn2: UIButton!
    @IBOutlet weak var checkBtn3: UIButton!
    
    @IBOutlet weak var check2Btn1: UIButton!
    @IBOutlet weak var check2Btn2: UIButton!
    
    @IBOutlet weak var yes1: UILabel!
    @IBOutlet weak var yes2: UILabel!
    @IBOutlet weak var yes3: UILabel!
    
    @IBOutlet weak var no1: UILabel!
    @IBOutlet weak var no2: UILabel!
    
    fileprivate var tempBtn1:UIButton?
    fileprivate var tempBtn2:UIButton?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // nav
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem.init(
                image: Rimage.guanbi()!.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(dissMiss))
        self.navigationItem.title = Rstring.agreeMent_nav_title.localized()
        
        agreeTitle1.text = Rstring.agreeMent_title1.localized()
        agreeTitle2.text = Rstring.agreeMent_title2.localized()
        agreeTitle3.text = Rstring.agreeMent_title3.localized()
        agressContent1.text = Rstring.agreeMent_select1.localized()
        agressContent2.text = Rstring.agreeMent_select2.localized()
        
        yes1.text = Rstring.common_yes.localized()
        yes2.text = Rstring.common_yes.localized()
        yes3.text = Rstring.agreeMent_select3.localized()

        no1.text = Rstring.common_no.localized()
        no2.text = Rstring.common_no.localized()

        
        self.selectAgreeView(view: agressView1, isSelect: true)
        self.selectAgreeView(view: agressView2, isSelect: false)

        checkBtn3.isSelected = true
        tempBtn1 = checkBtn3
        check2Btn1.isSelected = true
        tempBtn2 = check2Btn1

    }

    
    func selectAgreeView(view:UIView, isSelect: Bool)  {
        view.setCornerRadius(radius: 3)
        view.setBorderWidth(width: 1)
        if isSelect {
            view.setBorderColor(color: Rcolor.ed5634())
            if view == agressView1 {
                agressSelect1.isHidden = false
            } else {
                agressSelect2.isHidden = false
            }
        } else {
            view.setBorderColor(color: Rcolor.cccccC())
            if view == agressView1 {
                agressSelect1.isHidden = true
            } else {
                agressSelect2.isHidden = true
            }
        }
    }
    
    @objc func dissMiss()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Outlet action
    @IBAction func tapAgressView1(_ sender: Any) {
        if agressSelect1.isHidden {
            self.selectAgreeView(view: agressView1, isSelect: true)
            self.selectAgreeView(view: agressView2, isSelect: false)
        }
    }
    
    @IBAction func tapAgressView2(_ sender: Any) {
        if agressSelect2.isHidden {
            self.selectAgreeView(view: agressView1, isSelect: false)
            self.selectAgreeView(view: agressView2, isSelect: true)
        }
    }
    
    @IBAction func agressButton1(_ sender: Any) {
        if !checkBtn1.isSelected {
            tempBtn1?.isSelected = false
            checkBtn1.isSelected = true
            tempBtn1 = checkBtn1
        }
    }
    
    @IBAction func agressButton2(_ sender: Any) {
        if !checkBtn2.isSelected {
            tempBtn1?.isSelected = false
            checkBtn2.isSelected = true
            tempBtn1 = checkBtn2
        }
    }
    
    @IBAction func agressButton3(_ sender: Any) {
        if !checkBtn3.isSelected {
            tempBtn1?.isSelected = false
            checkBtn3.isSelected = true
            tempBtn1 = checkBtn3
        }
    }
    
    @IBAction func agress2Button1(_ sender: Any) {
        if !check2Btn1.isSelected {
            tempBtn2?.isSelected = false
            check2Btn1.isSelected = true
            tempBtn2 = check2Btn1
        }
    }
    @IBAction func agress2Button2(_ sender: Any) {
        if !check2Btn2.isSelected {
            tempBtn2?.isSelected = false
            check2Btn2.isSelected = true
            tempBtn2 = check2Btn2
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
