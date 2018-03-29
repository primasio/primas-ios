//
//  WorthPage.swift
//  Primas
//
//  Created by figs on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class WorthPage: BaseViewController {

    @IBOutlet weak var headView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var tipLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var historyLbl: UILabel!
    @IBOutlet weak var availableText: UILabel!
    @IBOutlet weak var historyText: UILabel!
    @IBOutlet weak var historyBtn: UIButton!
    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var navTokenLabel: UILabel!
    
    fileprivate var tempTimestamp = ""
    fileprivate var tempOffset = request_start_offset
    fileprivate let Header_animationTime:TimeInterval = 0.5

    lazy var loginView:UIView = {
        let vc = Rstoryboard.noticeView.noticeLogin()!
        vc.display = .NoticeLogin_minePage
        vc.view.frame = self.view.bounds
        vc.settingBtn.isHidden = true
        vc.createAction = {
            self.presentVc(Rstoryboard.builtWallet.builtWallet()!)
        }
        return vc.view
    }()
    var contentList = Array<WorthRecord>()
    // Set StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return.lightContent }
    }
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        X_Notification.addObserver(
            self,
            selector: #selector(WorthPage.loginSuccess),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
        
        // without user
        if Have_User() {
            commomSet()
        } else {
            self.view.addSubview(self.loginView)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getValue()
    }
    
    
    func commomSet()  {
        initViews()
        
        // Do any additional setup after loading the view.
        self.worth = WorthModel.testModel()
        
        // balance
        self.numLbl.text = "0"
        // balance locked
        self.tipLbl.text = "0"
        // available value
        self.availableText.text = "0"
        // history value
        self.historyText.text = "0"
        
        navTokenLabel.transform = CGAffineTransform.init(scaleX: 1, y: 0)
        navTokenLabel.isHidden = true
        
        

        tableView.emptyFooter()
        tableView.initMJHeader {
            self.getValue()
            self.tempTimestamp = Utility.currentTimeStamp()
            self.tempOffset = request_start_offset
            self.tableView.resetNoMoreData()
            self.getIncentives(start: self.tempTimestamp, offset: self.tempOffset)
        }
        
        tableView.initMJFooter {
            self.getIncentives(start: self.tempTimestamp, offset: self.tempOffset)
        }
        
        self.tempTimestamp = Utility.currentTimeStamp()
        self.tempOffset = request_start_offset
        self.getIncentives(start: self.tempTimestamp, offset: self.tempOffset)
    }
    
    func getIncentives(start: String, offset: Int)  {
        guard Have_User() else { return }
        let address = UserTool.shared.userAddress()
        // "0xa8D2D595C6F8171F767FDa0bb6530bdDD19704c8"
        ValueAPI.incentives(
            address: address,
            Start: start,
            Offset: offset,
            suc: { models  in
                if offset == request_start_offset {
                    self.contentList.removeAll()
                }
                for model in models {
                    self.contentList.append(model)
                }
                self.tableView.reloadData()
                self.tableView.endMJRefresh()
                self.tempOffset += models.count
                if models.count < articles_page_size {
                    self.tableView.noMoreData()
                }
        }) { (error) in
            debugPrint(error)
            self.hudShow(error.localizedDescription)
            self.tableView.endMJRefresh()
        }

    }
    
    
    func getValue() {
        
        guard Have_User() else { return }
        
        // get all balance
        UserAPI.getUserInfo(
            Address:nil,
            suc: { (userModel) in
                self.numLbl.text = userModel.Balance?.toPstValue()
                self.navTokenLabel.text = Rstring.all_FUNDS.localized() + ": " + (userModel.Balance?.toPstValue())!  + " PST"
        }) { (error) in
            debugPrint(error)
            self.hudShow(error.localizedDescription)
        }
        
        // get available balance value
        ValueAPI.getBalance(suc: { value in
            self.availableText.text = value
        }) { (error) in
            debugPrint(error)
            self.hudShow(error.localizedDescription)
        }
        
        // get balance locked value
       ValueAPI.getBalanceLocked(
            suc: { value in
                self.tipLbl.text = Rstring.value_pst_locked.localized() + " " +  value
        }) { (error) in
            debugPrint(error)
            self.hudShow(error.localizedDescription)
        }
        
    }
    
    func initViews(){
        
        headView.image = Rimage.mine_bg()
        tableView.register(Rnib.worthCell)
        tableView.separatorColor = Color_E5E5E5
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
        tableView.backgroundColor = Color_F7F7F7
        tableView.ept.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        titleLbl.text = Rstring.record_mine.localized()
        availableLbl.text = Rstring.record_available.localized()
        historyLbl.text = Rstring.record_yesterday.localized()
    }
    
    var worth: WorthModel!{
        didSet{
            numLbl.text = String.init(format: "%0.3f", worth.worth_num)
            availableText.text = String.init(format: "%d", worth.available_num)
            var yesterday = String.init(format: "%d", worth.yesterday_num)
            if worth.yesterday_num > 0 {
                yesterday = "+" + yesterday
            }
            historyText.text = yesterday
            historyBtn.setTitle(Rstring.record_yesterday2(worth.hisroty_num), for: .normal)
        }
    }
    
    @objc func loginSuccess()  {
        if self.view.subviews.contains(self.loginView) {
            self.loginView.removeFromSuperview()
        }
        commomSet()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - UITableViewDelegate / UITableViewDataSource
extension WorthPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WorthCell = tableView.dequeueReusableCell(withIdentifier: Rnib.worthCell.identifier, for: indexPath) as! WorthCell
        let model = contentList[indexPath.row]
        cell.model = model;
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

// MARK: - EmptyDataSource
extension WorthPage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return Utility.emptyAttributed(Rstring.common_no_content.localized())
    }
    
    func verticalSpaceForEmpty(in view: UIView) -> CGFloat {
        return VerticalSpaceForEmpty
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return Rimage.zanwushuju()
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}

extension WorthPage: UIScrollViewDelegate  {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offeset = scrollView.contentOffset.y
        let headerH:CGFloat = 236
        let max:CGFloat = headerH - UIDevice.navTopOffset()
        if offeset <= 0 {
            headerViewTop.constant = 0
            maskView.backgroundColor = UIColor.clear
            view.updateConstraintsIfNeeded()
            NavLabelShow(flag: false)
        } else if offeset > 0 && offeset < max {
            headerViewTop.constant = -offeset
            let p = offeset / max
            maskView.backgroundColor = Color_ED5634.withAlphaComponent(p)
            view.updateConstraintsIfNeeded()
            NavLabelShow(flag: false)
         } else if offeset >= max {
            headerViewTop.constant = -max
            maskView.backgroundColor = Color_ED5634
            view.updateConstraintsIfNeeded()
            NavLabelShow(flag: true)
        }
    }
    
    func NavLabelShow(flag : Bool)  {
        if  flag {
            if self.navTokenLabel.isHidden {
                self.navTokenLabel.isHidden = false
                UIView.animate(withDuration: Header_animationTime, animations: {
                    self.navTokenLabel.transform = CGAffineTransform.identity
                }, completion: { (flag) in
                    if flag { self.navTokenLabel.isHidden = false }
                })
            }
        } else {
            if !self.navTokenLabel.isHidden {
                UIView.animate(withDuration: Header_animationTime, animations: {
                    self.navTokenLabel.transform = CGAffineTransform.init(scaleX: 1, y: 0)
                }, completion: { (flag) in
                    if flag { self.navTokenLabel.isHidden = true }
                })
            }
        }
    }
    
}
