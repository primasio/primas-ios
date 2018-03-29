//
//  CycleCreatePage.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CycleCreatePage: BaseViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var desText: UITextView!
    @IBOutlet weak var createBtn: UIBarButtonItem!
    
    @IBOutlet weak var placeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftBaritem = UIBarButtonItem.init(
            title: Rstring.common_Cancel.localized(),
            style: .plain,
            target: self,
            action: #selector(dissMiss))
        self.navigationItem.leftBarButtonItem = leftBaritem

        self.title = Rstring.cycle_creat_title.localized()
        createBtn.title = Rstring.cycle_creat_confirm.localized()
        
        //nameText.attributedPlaceholder = NSAttributedString.init(string: Rstring.cycle_creat_title_tip.localized(), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 19), NSAttributedStringKey.foregroundColor: Rcolor.cccccC])
        nameText.placeholder = Rstring.cycle_creat_title_tip.localized()
        placeLbl.text = Rstring.cycle_creat_des_tip.localized()
        // Do any additional setup after loading the view.
        
        autoPresentNoPST(usePst: CREATE_CIRCLE_PST, disPlay: .create_circle)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav(false, animated: true)
    }
    
    @IBAction func goCreate() {
        self.view.endEditing(true)
        if nameText.text?.length == 0 {
            self.hudShow(Rstring.post_no_title.localized())
            return
        }
        if desText.text?.length == 0 {
            self.hudShow(Rstring.post_no_des.localized())
            return
        }
        enoughBalance(usePst: CREATE_CIRCLE_PST) { (flag) in
            if flag {  self.createAction() }
        }
    }
    
    func createAction()  {

        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.costValue = POST_ARTICLE_PST
        //vc.lockLabel.text = Rstring.cycle_create_lock.localized()
        vc.pwdBlock = { [weak self] (pwd) in
            self?.createCycle(pwd: pwd)
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)
    }
    
    @objc func dissMiss()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createCycle(pwd: String) {
        let hud = self.hudLoading("")
        GroupApi.createGroup(passphrase: pwd, title: nameText.text!, des: desText.text!, suc: { (model) in
            // 创建成功 进去圈子主页
            let cycle = Rstoryboard.cyclePage.cycleIndexPage()
            cycle?.cycleModel = model
            self.pushVc(cycle!)
            hud.hide(animated: true)
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.hudShow(Rstring.cycle_creat_sucess.localized(), afterDelay: 3, offset: UIDevice.height() - 200)
        }) { (error) in
            if IS_PwdError(error) {
                Utility.delay(0.5, closure: {
                    self.pwdErrorAlert {  self.goCreate() }
                })
            } else {
                self.hudShow(error.localizedDescription)
            }
            hud.hide(animated: true)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CycleCreatePage : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        var text = textView.text
        if (text != nil && text!.length > 200) {
            text = text!.substring(from: 0, to: 200)
            textView.text = text
        }
        placeLbl.isHidden = text != nil && text!.length > 0
    }
    
    @IBAction func textFieldChanged(_ textField: UITextField){
        var text = textField.text
        if (text != nil && text!.length > 20) {
            text = text!.substring(from: 0, to: 20)
            textField.text = text
        }
    }
}
