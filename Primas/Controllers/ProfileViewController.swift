//
//  ProfileViewController.swift
//  Primas
//
//  Created by wang on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var profile: ProfileView = ProfileView()
    var profileModel: ProfileModel = {
        return ProfileModel.generateTestData()
    }()
    // var profileView: ProfileView = ProfileView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(profile)
        profile.bind(profileModel)

        profile.snp.makeConstraints {
            make in 
            make.left.right.top.bottom.equalTo(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.toolbarItems = self.navigationController?.toolbar.items
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.navigationBar.isTranslucent = true
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
