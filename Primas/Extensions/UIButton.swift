//
//  UIButton.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/12/6.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    // MARK: - Back Button
    class func backButton() -> UIButton {
        let normal = UIImage.init(named: "back")
        let highlight = UIImage.init(named: "back")
        let button = UIButton.init(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        button.setImage(normal, for: .normal)
        button.setImage(highlight, for: .highlighted)
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -25, bottom: 0, right: 0)
        return button
    }
    
    
    // MARK: - Back Button
    class func titleButton(
        title: String,
        color: UIColor,
        fontSize: CGFloat = 16) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect.init(x: 0, y: 0, width: 44, height: 44)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.tintColor = color
        return button
    }
    
    // MARK: - Set background image with  normal and highlighted
    func setImage(normal:String, highlited:String)  {
        let normal = UIImage.init(named: normal)
        let highlight = UIImage.init(named: highlited)
        self.setImage(normal, for: .normal)
        self.setImage(highlight, for: .highlighted)
    }
    
    // MARK: - Get Button with (Set background image with  normal and highlighted)
    class func built(normal:String, highlited:String) -> UIButton {
        let normal = UIImage.init(named: normal)
        let highlight = UIImage.init(named: highlited)
        let button = UIButton.init(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect.init(x: 0, y: 0,
                                   width: normal!.size.width,
                                   height: normal!.size.height)
        button.setImage(normal, for: .normal)
        button.setImage(highlight, for: .highlighted)
        return button
    }
    
    // MARK: - Close button
    class func closeNavButton() -> UIButton {
        let normal = Rimage.guanbi()!
        let highlight = Rimage.guanbi()!
        let button = UIButton.init(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect.init(x: 0, y: 0,
                                   width: 44,
                                   height: 44)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
        button.setImage(normal, for: .normal)
        button.setImage(highlight, for: .highlighted)
        return button
    }
}
