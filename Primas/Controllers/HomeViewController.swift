//
//  HomeViewController.swift
//  Primas
//
//  Created by wang on 05/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import UIKit
import Foundation

class HomeViewController: UIViewController {
  var cellList: Array<CellModel>?

  var homeView: HomeView = {
    let _homeView = HomeView(frame: .zero)
    return _homeView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(homeView)

    homeView.snp.makeConstraints { (make) in
      make.top.right.bottom.left.equalTo(self.view);
    }
    
    setup()
  }
    
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setToolbarHidden(false, animated: false)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override func viewDidAppear(_ animated: Bool) {
//    navigationController?.pushViewController(TestViewController(), animated: false)
   // navigationController?.pushViewController(ProfileViewController(), animated: true)
  }

  func setup() {
    self.title = "Home"

    cellList = CellModel.generateTestData()
    
    homeView.tableView.dataSource = self
    homeView.tableView.delegate = self

    self.navigationController?.toolbar.contentMode = .scaleToFill
    self.toolbarItems = app().toolbar.getItems()

    forTest()
  }

  func forTest() {
//    let button = homeView.search.viewWithTag(1)
//    let tapedEvent = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.showTestViewController))
//    tapedEvent.numberOfTapsRequired = 1
//    
//    button?.isUserInteractionEnabled = true
//    button?.addGestureRecognizer(tapedEvent)
  }
    
    func showTestViewController() {
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }

    func selectTaped() {
      print("taped.........")
    }

}


// Mark: HomeViewController - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        // show article detail
        self.navigationController?.pushViewController(ArticleDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        view.backgroundColor = PrimasColor.shared.main.light_background_color
        return view
    }
}
