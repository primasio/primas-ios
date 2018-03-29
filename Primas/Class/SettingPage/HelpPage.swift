//
//  HelpPage.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/9.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit

class HelpPage: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var webbView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.startAnimating()
        self.webbView.delegate = self
        self.webbView.backgroundColor = UIColor.white
        self.navigationItem.title = Rstring.set_HEPLER_TITLE.localized()
        let padURF = R.file.帮助中心Pdf()!
        self.webbView.scalesPageToFit = true
        self.webbView.loadRequest(NSURLRequest.init(url: padURF) as URLRequest)
    }

    // MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
        activity.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
