//
//  NoticeArticleInfo.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/21.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class NoticeArticleInfo: BaseViewController {

    var articleAddress = ""
    var subContentText = ""
    var finishBlock:NoneBlock?
    
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var topMaskView: UIView!
    @IBOutlet weak var blockChainTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var ddtcpTitle: UILabel!
    @IBOutlet weak var subContent: UILabel!
    @IBOutlet weak var bootonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // configure UI
        maskView.setCornerRadius(radius: 12)
        topMaskView.setCornerRadius(radius: 180)
        // set content
        blockChainTitle.text = Rstring.article_blockChain_address.localized()
        // address.text = ""
        ddtcpTitle.text = Rstring.common_dtcp.localized()
        // subContent.text = ""
        bootonButton.setTitle(Rstring.look_article_info.localized(), for: .normal)
        
        address.text = articleAddress
        subContent.text = subContentText
        
        self.view.backgroundColor = UIColor.clear
        maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
     }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: animationTime) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(maskAplha)
            self.maskView.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - Outlet action
    
    @IBAction func quickLookAction(_ sender: Any) {
        UIView.animate(withDuration: animationTime, animations: {
            self.maskView.transform = CGAffineTransform(translationX: 0, y: Animation_offsetY)
            self.view.backgroundColor = UIColor.clear
        }) { (flag) in
            if flag {
                self.dismiss(animated: false, completion: nil)
                if self.finishBlock != nil {
                    self.finishBlock!()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
