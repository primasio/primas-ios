//
//  GesturePopNav.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/24.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class GesturePopNav: UINavigationController, UIGestureRecognizerDelegate {

//    lazy var tap: UITapGestureRecognizer = {
//        return UITapGestureRecognizer.init(target: self, action: #selector(goBack) )
//    }()
    
    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        // self.navigationBar.isTranslucent = false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    override func pushViewController(_ viewController:UIViewController, animated:Bool) {
        viewController.navigationItem.hidesBackButton=true
        if childViewControllers.count > 0 {
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem =
                UIBarButtonItem.init(
                    image: Rimage.back()!.withRenderingMode(.alwaysOriginal),
                    style: .plain,
                    target: self,
                    action: #selector(goBack))
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func goBack()  {
       popViewController(animated: true)
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
