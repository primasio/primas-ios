//
//  MineCyclePage.swift
//  Primas
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class MineCyclePage: BaseViewController, CustomNavBarViewDelegate {

    @IBOutlet weak var headView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cycleImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var shouyiBtn: UIButton!
    @IBOutlet weak var actionBtn: UIButton!
    
    var contentList = [ArticelModel]()
    
    fileprivate var tempTimestamp = ""
    fileprivate var tempOffset = request_start_offset
    fileprivate var userName = ""

    var mineUser = UserModel.testModel()
    var cycleModel: CycleModel!
    let navBarView = CustomNavBarView.navBar()
    var circleImg: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        setTableView()
        
        updateHeader()
        // Do any additional setup after loading the view.
        
        UserTool.shared.getUserModel(handle: { (model) in
            self.userName = model.Name!
            self.tableView.reloadData()
        }) { (error) in
            debugPrint(error)
        }
    }

    func setNavBar() {
        if circleImg != nil {
            cycleImage.image = circleImg
        }
        cycleImage.setCornerRadius(radius: 4)
        self.view.addSubview(navBarView)
        navBarView.delegate = self
        navBarView.title = cycleModel.Title
        navBarView.rightBtn.isHidden = true
        navBarView.backgroundColor = UIColor.white
        navBarView.showColor = Color_51
    }
    
    func updateHeader(){
        actionBtn.setCornerRadius(radius: 2)
        titleLbl.text = cycleModel.Title
        infoLbl.text = cycleModel.get_info_string()
        desLbl.text = cycleModel.Description
        shouyiBtn.setTitle(String.init(format: "%0.2f", cycleModel.worth), for: .normal)
    }
    
    func setTableView(){
        //header
        actionBtn.setTitle(Rstring.cycle_goto.localized(), for: .normal)
        tableView.tableHeaderView = headView
        tableView.backgroundColor = Color_F7F7F7
        tableView.emptyFooter()
        tableView.estimatedRowHeight = 0
        tableView.separatorStyle = .none
        // tableView.ept.dataSource = self
        tableView.register(Rnib.imageTextCell)
        //tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
//        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: ARTICLE_FOOT_HEIGHT))
//        view.backgroundColor = Rcolor.eff1F7()
//        tableView.tableFooterView = view
        
        tableView.initMJHeader {
            self.tempTimestamp = Utility.currentTimeStamp()
            self.tempOffset = request_start_offset
            self.loadData(offset: self.tempOffset)
            
        }
        tableView.initMJFooter {
            self.loadData(offset: self.tempOffset)
        }
        
        loadData(offset: tempOffset)
    }
    
    @IBAction func onGoCycle(){
        let cycle = Rstoryboard.cyclePage.cycleIndexPage()!
        cycle.cycleModel = cycleModel
        if circleImg != nil {
            cycle.backImg = self.circleImg
        }
        self.pushVc(cycle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.navigationController!.isNavigationBarHidden {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    //返回
    func leftAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var emptyView: CustomEmptyView = {
        let height = UIDevice.height() - headView.height
        let view = CustomEmptyView.emptyView(height: height)
        view.showCycleEmpty()
        return view
    }()

}

extension MineCyclePage {
    
    // load data
    func loadData(offset:Int)  {
        
        guard Have_User() else { return }
        guard !cycleModel.DNA.isEmpty else {  return }
        let address = UserTool.shared.userAddress()
        
        GroupApi.userGroupArticles(
            dna: cycleModel.DNA,
            UserAddress: address,
            Offset: String(offset),
            suc: { (articles) in

                if offset == request_start_offset {
                    self.tableView.resetNoMoreData()
                    self.contentList.removeAll()
                }
                
                for item in articles{
                    self.contentList.append(item)
                }
                self.tableView.reloadData()
                
                self.tableView.endMJRefresh()
                self.tempOffset += articles.count
                
                self.updateEmptyView()
                if articles.count < articles_page_size {
                    self.tableView.noMoreData()
                }
                
        }) { (error) in
            debugPrint(error)
            self.tableView.endMJRefresh()
            self.hudShow(error.localizedDescription)
            self.updateEmptyView()
        }
    }
    
    func updateEmptyView() {
        if self.contentList.count == 0 {
            self.tableView.tableFooterView = self.emptyView
        }else {
            self.tableView.tableFooterView = nil
        }
    }
}

// MARK: - UITableViewDelegate / UITableViewDataSource
extension MineCyclePage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ImageTextCell = tableView.dequeueReusableCell(withIdentifier: Rnib.imageTextCell.identifier, for: indexPath) as! ImageTextCell
        if !self.contentList.isEmpty {
            let model = contentList[indexPath.section]
            model.Author?.Name = self.userName
            cell.setModel(articleModel: model)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.contentList.isEmpty { return 0 }
        let model = contentList[indexPath.section]
        return ImageTextCell.getCellHeight(articleModel: model)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: ARTICLE_FOOT_HEIGHT))
        view.backgroundColor = Color_fafafa
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !self.contentList.isEmpty {
            let model = contentList[indexPath.section]
            let vc = Rstoryboard.homePage.articleDetail()
            vc?.dna = model.DNA!
            vc?.GroupDNA = cycleModel.DNA!
            pushVc(vc!)
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ARTICLE_FOOT_HEIGHT
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = scrollView.contentOffset.y/headView.height
        navBarView.titleLbl.textColor = Color_51.withAlphaComponent(alpha)
    }

}
// MARK: - EmptyDataSource
extension MineCyclePage: EmptyDataSource {
    
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
