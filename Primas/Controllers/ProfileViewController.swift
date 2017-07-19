//
//  ProfileViewController.swift
//  Primas
//
//  Created by wang on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var oldContentOffset = CGPoint.zero
    
    var cellList: Array<CellModel>?
    var profile: ProfileView = ProfileView()
    var profileModel: ProfileModel = {
        return ProfileModel.generateTestData()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(profile)
        profile.bind(profileModel)

        profile.snp.makeConstraints {
            make in 
            make.left.right.top.bottom.equalTo(self.view)
        }

        profile.table.dataSource = self
        profile.table.delegate = self

        cellList = CellModel.generateTestData()
        
        self.navigationItem.leftBarButtonItem = ViewTool.generateNavigationBarItem(Iconfont.setting)
        self.navigationItem.rightBarButtonItem = ViewTool.generateNavigationBarItem(Iconfont.add)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.toolbarItems = app().toolbar.getItems()
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        app().toolbar.current = .myself
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


// Mark: HomeViewController - UITableViewDataSource, UITableViewDelegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.cellList?.count != 0 {
          return (cellList?.count)!
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: HomeListCell.registerIdentifier, for: indexPath) as! HomeListCell
      cell.bind((cellList?[indexPath.row])!)
      return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return HomeListCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app().client.selectedArticleId = (cellList?[indexPath.row].id)!
        
        toController(.article)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        view.backgroundColor = PrimasColor.shared.main.light_background_color
        return view
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        let topConstant = profile.headerViewTopConstraint!.layoutConstraints[0].constant
        let topConstantAbs = 0 - topConstant
        
        if delta > 0 && topConstantAbs < CGFloat(240.0) && scrollView.contentOffset.y > 0 {
            
            let offsetDelta = topConstant - delta < -240.0 ? -240.0 : topConstant - delta
            
            profile.headerViewTopConstraint!.update(offset: offsetDelta)
            scrollView.contentOffset.y -= delta
        }
        
        if delta < 0 && topConstantAbs > CGFloat(0.0) && scrollView.contentOffset.y < 0 {
            
            let offsetDelta = topConstant - delta >= 0 ? 0 : topConstant - delta
            
            profile.headerViewTopConstraint!.update(offset: offsetDelta)
            scrollView.contentOffset.y -= delta
        }
        
        oldContentOffset = scrollView.contentOffset
    }
}
