//
//  HomePage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class HomePage: BaseViewController {

    @IBOutlet weak var searchMask: UIView!
    @IBOutlet weak var topSearchBar: UISearchBar!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    fileprivate var tempSelectBtn:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        button1.setTitle(Rstring.common_home.localized(), for: .normal)
        button2.setTitle(Rstring.cycle_discover.localized(), for: .normal)
        tempSelectBtn = button1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav()
    }
    
    // MARK: - outlet action
    
    @IBAction func button1Action(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if tempSelectBtn != button {
            clickBtnAction(num: 1, button: button)
        }
    }
    @IBAction func button2Action(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if tempSelectBtn != button {
            clickBtnAction(num: 2, button: button)
        }
    }
    
    func getBtn(num: Int) -> UIButton {
        if num == 0 {
            return button1
        } else {
            return button2
        }
    }
    
    func clickBtnAction(num: Int, button: UIButton)  {
            let sw = kScreenW
            self.scrollview.setContentOffset(CGPoint.init(
                x: sw * CGFloat.init((num - 1)),
                y: 0), animated: true)
            tempSelectBtn?.setTitleColor(Rcolor.c333333(), for: .normal)
            tempSelectBtn = button
            button.setTitleColor(Rcolor.ed5634(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UISearchBarDelegate
extension HomePage:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UIScrollView
extension HomePage:UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sw = kScreenW
        let w = sw / 2
        let h = CGFloat.init(1.5)
        let y = CGFloat.init(40) - h
        let ratio = w / sw
        let scroll =  scrollView.contentOffset.x
        redView.frame = CGRect.init(x: scroll * ratio, y: y, width: w, height: h)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tempSelectBtn?.setTitleColor(Rcolor.c333333(), for: .normal)
        let scroll =  scrollView.contentOffset.x
        let index = scroll / kScreenW
        let button = getBtn(num: Int(index))
        tempSelectBtn = button
        button.setTitleColor(Rcolor.ed5634(), for: .normal)
    }
    
}
