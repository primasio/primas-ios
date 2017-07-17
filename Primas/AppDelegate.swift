//
//  AppDelegate.swift
//  Primas
//
//  Created by wang on 03/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit
import SwiftIconFont

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationController!
    var cachedViewControllers: [ViewControllers: UIViewController] = [:]
    var modal: ModalViewComponent = ModalViewComponent(subView: UIView(), height: 99)
    lazy var toolbar: ToolBar = { ToolBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: (self.navigation!.toolbar.frame.height))) }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        self.window!.frame = UIScreen.main.bounds
        self.window!.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white
        self.window?.addSubview(modal)

        let client = Client()

        let homeViewController = ViewControllers.home.map()
        self.cachedViewControllers[ViewControllers.home] =  homeViewController

        self.navigation = UINavigationController(navigationBarClass: UINavigationBar.self, toolbarClass: ToolBar.self)
        self.navigation.pushViewController(homeViewController, animated: false)
        self.navigation.navigationBar.isTranslucent = false
        self.navigation.toolbar.isTranslucent = false
        
        self.window!.rootViewController = navigation

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

