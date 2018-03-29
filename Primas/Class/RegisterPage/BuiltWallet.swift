//
//  BuiltWallet.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/1.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class BuiltWallet: UIViewController {

    // View
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    @IBOutlet weak var restoreButton2: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // Set StatusBar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return.lightContent }
    }
    
   // MARK: - Life Cycle
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // localized String
        registerButton.setTitle(Rstring.built_WALLET.localized(), for: .normal)
        restoreButton.setTitle(Rstring.import_MNEMONIC.localized(), for: .normal)
        restoreButton2.setTitle(Rstring.import_KEYSTORE.localized(), for: .normal)
        
        X_Notification.addObserver(
            self,
            selector: #selector(BuiltWallet.dissMiss),
            name: GET_Notification_Name(.register_Finish),
            object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav()
    }
    
    @objc func dissMiss()  {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Outlet Action
    @IBAction func closePage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// import Noemonic
    @IBAction func importNoemonic(_ sender: Any) {
        let vc:ImportPage = Rstoryboard.builtWallet.importPage()!
        vc.disPlayType = .mnemonic
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// import Keystore
    @IBAction func importKeystore(_ sender: Any) {
        let vc:ImportPage = Rstoryboard.builtWallet.importPage()!
        vc.disPlayType = .keystore
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /// Create account
    @IBAction func createAccount(_ sender: Any) {
        let vc:ImportPage = Rstoryboard.builtWallet.importPage()!
        vc.disPlayType = .register
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
