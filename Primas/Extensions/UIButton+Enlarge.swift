//
//  UIButton+Enlarge.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

class ButtonArea: NSObject {
    var tempArea: [UIButton : [CGFloat]] = Dictionary()
    static var shared:ButtonArea = {
        let instance = ButtonArea();
        return instance;
    }();
    private override init() {}
}

extension UIButton {
    
    func enlargedRect(
        top:CGFloat = 0,
        right:CGFloat = 0,
        botton:CGFloat = 0,
        left: CGFloat = 0)  {
        let instance = ButtonArea.shared
        instance.tempArea.updateValue([top, right, botton, left],
                                      forKey: self)
    }
    
     fileprivate func enlargedRect() -> CGRect {
        let instance = ButtonArea.shared
        let array = instance.tempArea[self]
        if array == nil {  return self.bounds }
        let x = self.bounds.origin.x - array![3]
        let y = self.bounds.origin.y - array![0]
        let w = self.bounds.size.width + array![3] +  array![1]
        let h = self.bounds.size.height + array![0] +  array![2]
        return CGRect.init(x: x, y: y, width: w, height: h)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = self.enlargedRect()
        if rect.equalTo(self.bounds) {
            return super.hitTest(point, with: event)
        }
        return rect.contains(point) ? self : nil
    }
}
