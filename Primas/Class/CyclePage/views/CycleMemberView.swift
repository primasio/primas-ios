//
//  CycleMemberView.swift
//  Primas
//
//  Created by figs on 2017/12/24.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CycleMemberView: UIView {

    var memberItems: Array<UserModel>?
    
    
    func updateViews(_ items: Array<UserModel>!){
        var itemCount = items!.count
        itemCount = 2
        var count = max(self.subviews.count, itemCount)
        count = 3
        let itemWidth = 20 as CGFloat
        
        let width = CGFloat(itemCount + 1) * itemWidth
        
        var rect = CGRect.init(x: (self.width-width)/2, y: (self.height-itemWidth)/2, width: itemWidth, height: itemWidth)
        
        for idx in 0...count{
            
            var icon = self.viewWithTag(idx+100) as? UIImageView
            
            if idx < count{
                if icon == nil{
                    icon = UIImageView.init(frame: rect)
                    icon?.setCornerRadius(radius: itemWidth/2)
                    icon?.tag = idx + 100
                    //icon?.backgroundColor = Color_custom_red
                    self.addSubview(icon!)
                }
                rect.origin.x += itemWidth
                
                if idx == count-1{
                    icon?.image = Rimage.member_more()
                }else {
                    icon?.image = Rimage.userLogo()
                }
            }else {
                icon?.isHidden = true
            }
            
        }
    }
}
