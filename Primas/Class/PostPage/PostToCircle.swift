//
//  PostToCircle.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/28.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class PostToCircle: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var datas:[CycleModel] = []
    var selectedGroups:[String] = []
    var articleDNA:String = ""
    var tempOffset = request_start_offset
    
    // MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()

        // configuer nav
        self.navigationItem.title = Rstring.post_to_circle.localized()
        let leftBaritem = UIBarButtonItem.init(
            title: Rstring.common_Cancel.localized(),
            style: .plain,
            target: self,
            action: #selector(dissMiss))
        self.navigationItem.leftBarButtonItem = leftBaritem
        
        tableView.backgroundColor = Color_F7F7F7
        tableView.emptyFooter()
        tableView.rowHeight = 63
        tableView.ept.dataSource = self
        tableView.register(Rnib.postCircleCell)
        
        tableView.initMJHeader {
            self.tempOffset = request_start_offset
            self.datas.removeAll()
            self.networkRequest(Offset: self.tempOffset)
        }
        networkRequest(Offset: request_start_offset)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav(false, animated: true)
    }
    
    // set right nav item
    func setRightItem()  {
        if self.datas.isEmpty {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            let rightButton = UIBarButtonItem.init(
                title: Rstring.common_Nextstep.localized(),
                style: .plain,
                target: self,
                action: #selector(send))
            
            self.navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    // MARK: - Private action
    @objc func dissMiss()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// send article to circle
    @objc func send()  {
        
        guard !(self.articleDNA.isEmpty) else { return }
        guard !self.selectedGroups.isEmpty else {
            self.hudShow(Rstring.select_zero_circle.localized())
            return
        }
        
        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.display = .useHp
        vc.pwdBlock = {  (pwd) in
            self.groupNetWork(pwd: pwd)
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)
    }
    
    // add group dna
    func selectGroup(dna: String)  {
        if selectedGroups.contains(dna) {
            selectedGroups.remove(at: selectedGroups.index(of: dna)!)
        } else {
            selectedGroups.append(dna)
        }
    }
    
    // MARK: - Network
    func networkRequest(Offset: Int)  {
        _ = hudLoading()
        GroupApi.joinedGroups(
            Start: "", Offset: "\(Offset)",
            suc: { (models) in
                for model in models {
                    if model.TxStatus == 2 {
                        self.datas.append(model)
                    }
                }
                self.tableView.endMJRefresh()
                self.tableView.reloadData()
                self.setRightItem()
                self.hudHide()
        }) { (error) in
            debugPrint(error)
            self.tableView.endMJRefresh()
            self.hudShow(error.localizedDescription)
            self.setRightItem()
            self.hudHide()
        }
    }
    
    
    func groupNetWork(pwd: String)  {
        
        let group = DispatchGroup()
        var result = false
        
        for dna in selectedGroups {
            group.enter()
            ArticleAPI.transmit(
                passphrase: pwd,
                dna: self.articleDNA,
                GroupDNAs: [dna],
                suc: {
                    group.leave()
                    result = true
            }) { (error) in
                debugPrint(error)
                self.hudShow(error.localizedDescription)
                group.leave()
                result = false
                if IS_PwdError(error) {
                    Utility.delay(0.5, closure: {
                        self.pwdErrorAlert {  self.send() }
                    })
                } else {
                    self.hudShow(error.localizedDescription)
                }
                return
            }
        }
        group.notify(queue: DispatchQueue.main) {
            if result {
                self.hudShow(Rstring.share_to_circle_success.localized())
                Utility.delay(0.5, closure: { self.dissMiss() })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITableViewDelegate / UITableViewDataSource

extension PostToCircle: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PostCircleCell = tableView.dequeueReusableCell(
            withIdentifier: Rnib.postCircleCell.identifier,
            for: indexPath) as! PostCircleCell
        if !self.datas.isEmpty {
            let model = self.datas[indexPath.row]
            cell.setData(model: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell:PostCircleCell = tableView.cellForRow(at: indexPath) as! PostCircleCell
        cell.isSelectItem = !cell.isSelectItem
        if !self.datas.isEmpty {
            let model = self.datas[indexPath.row]
            selectGroup(dna: model.DNA)
        }
    }
}


// MARK: - EmptyDataSource
extension PostToCircle: EmptyDataSource {
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
