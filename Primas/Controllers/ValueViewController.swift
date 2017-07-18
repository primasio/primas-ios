//
//  ValueViewController.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ValueViewController: UIViewController {
    var valueList: [AmountDetail] = []
    var valueView: ValueView = ValueView()
    var oldContentOffset = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.valueList = (app().client.user?.amountDetail)!
        self.valueView.table.delegate = self
        self.valueView.table.dataSource = self
        self.valueView.headerBind()
        
        self.view.addSubview(valueView)
        self.view.backgroundColor = UIColor.white

        valueView.snp.makeConstraints {
            make in 
            make.edges.equalTo(self.view)
        }
       
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ValueViewController.tap))
        tap.numberOfTapsRequired = 1
        self.valueView.detail.isUserInteractionEnabled = true
        self.valueView.detail.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.toolbarItems = self.navigationController?.toolbar.items
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true

        app().toolbar.current = .value
    }
    
    func tap() {
        self.navigationController?.pushViewController(ValueTopViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

// MARK -- UITableViewDataSource UITableViewDelegate

extension ValueViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueList[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.valueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ValueTableViewCell.registerIdentifier) as! ValueTableViewCell
        cell.bind(valueList[indexPath.section].items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ValueTableViewCell.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let date = valueList[section].date
        let headerView = ValueTableViewCell.generateSection(date)
        let _label = headerView.subviews[0] as! UILabel
        _label.snp.makeConstraints {
            make in
            make.left.equalTo(headerView).offset(SIDE_MARGIN)
            make.centerY.equalTo(headerView)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        let topConstant = valueView.headerViewTopConstraint!.layoutConstraints[0].constant
        let topConstantAbs = 0 - topConstant
        
        if delta > 0 && topConstantAbs < CGFloat(170.0) && scrollView.contentOffset.y > 0 {
            
            let offsetDelta = topConstant - delta < -170.0 ? -170.0 : topConstant - delta
            
            valueView.headerViewTopConstraint!.update(offset: offsetDelta)
            scrollView.contentOffset.y -= delta
        }
        
        if delta < 0 && topConstantAbs > CGFloat(0.0) && scrollView.contentOffset.y < 0 {
            
            let offsetDelta = topConstant - delta >= 0 ? 0 : topConstant - delta
            
            valueView.headerViewTopConstraint!.update(offset: offsetDelta)
            scrollView.contentOffset.y -= delta
        }
        
        oldContentOffset = scrollView.contentOffset
    }
}
