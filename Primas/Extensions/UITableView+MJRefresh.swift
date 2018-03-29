//
//  UITableView+MJRefresh.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/28.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import MJRefresh


class TableSingleton: NSObject {
    fileprivate var temp: [UIView : () -> ()] = Dictionary()
    fileprivate var temp2: [UIView : () -> ()] = Dictionary()

    static var shared:TableSingleton = {
        let instance = TableSingleton();
        return instance;
    }();
    private override init() {}
}


extension UITableView {
    
    // MARK: - Set Tableview empty Footer view
    func emptyFooter(){
        self.tableFooterView = UIView()
    }
    
    // MARK: - Use this Func to set tableview Pull refresh By MJRefresh
    ///
    /// - Parameter handle: closure to handle action
    
    func initMJHeader(_ handle: @escaping () -> ()) {
        let header = MJRefreshNormalHeader()
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        header.setRefreshingTarget(self, refreshingAction: #selector(fresh))
        self.mj_header =  header
        let test = TableSingleton.shared
        test.temp.updateValue(handle, forKey: self)
    }
    
    func initMJFooter(_ handle: @escaping () -> ()) {
        let footer = MJRefreshAutoNormalFooter()
        footer.setTitle(Rstring.common_no_more_data.localized(), for: .noMoreData)
        footer.setTitle(Rstring.common_pull_load.localized(), for: .idle)
        footer.setTitle(Rstring.common_LOAD.localized(), for: .refreshing)
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerFresh))
        self.mj_footer =  footer
        self.mj_footer.isAutomaticallyHidden = true
        let test = TableSingleton.shared
        test.temp2.updateValue(handle, forKey: self)
    }
    
    @objc func fresh() {
        let test = TableSingleton.shared
        test.temp[self]!()
    }
    
    @objc func footerFresh()  {
        let test = TableSingleton.shared
        test.temp2[self]!()
    }
    
    // MARK: - End MJRefrsh Action
    func endMJRefresh() {
        endHeaderRefresh()
        endFooterRefresh()
    }
    
    // MARK: - Indicate No more data
    func noMoreData()  {
            self.mj_footer.endRefreshingWithNoMoreData()
    }
    // MARK: - Restset No more data
    func resetNoMoreData()  {
        if self.mj_footer != nil {
            self.mj_footer.resetNoMoreData()
        }
    }
    
    // MARK: - End Header Action
    func endHeaderRefresh()  {
        if self.mj_header != nil && self.mj_header.isRefreshing {
            self.mj_header.endRefreshing()
        }
    }
    
    // MARK: - End Footer Action
    func endFooterRefresh() {
        if self.mj_footer != nil && self.mj_footer.isRefreshing {
            self.mj_footer.endRefreshing()
        }
    }
    
}

