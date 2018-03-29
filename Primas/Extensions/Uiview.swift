//
//  Uiview.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    
    // MARK: - set Border Color
    ///
    /// - Parameter color: UIColor
    func setBorderColor(color:UIColor)  {
        self.layer.borderColor = color.cgColor
    }
    
    
    // MARK: - set Border Width
    ///
    /// - Parameter width: Width
    func setBorderWidth(width: CGFloat)  {
        self.layer.borderWidth = width
    }
    
    
    // MARK: - Set CornerRadius
    ///
    /// - Parameter radius: radius
    func setCornerRadius(radius: CGFloat)  {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addCorner(roundingCorners: UIRectCorner, cornerSize: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
    
    // MARK: - Border Setting
    func borderSet(color:UIColor, width: CGFloat = 0, radius: CGFloat = 0)  {
        self.layer.borderColor = color.cgColor
        if width != 0 {
            self.layer.borderWidth = width
        }
        if radius != 0 {
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
    
    // MARK: - updateLayout
    func updateLayout()   {
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    
    
    var left: CGFloat{
        get{
            return self.frame.minX
        }
        set{
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    var top: CGFloat{
        get{
            return self.frame.minY
        }
        set{
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    var width: CGFloat{
        get{
            return self.frame.width
        }
        set{
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    
    var height: CGFloat{
        get{
            return self.frame.height
        }
        set{
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    
    var right: CGFloat{
        get{
            return self.frame.maxX
        }
        set{
            self.left = newValue-self.width
        }
    }
    
    
    var bottom: CGFloat{
        get{
            return self.frame.maxY
        }
        set{
            self.top = newValue-self.height
        }
    }
    
    var centerX: CGFloat{
        get{
            return self.frame.midX
        }
        set{
            self.left = newValue-self.width/2
        }
    }
    var centerY: CGFloat{
        get{
            return self.frame.midY
        }
        set{
            self.top = newValue-self.height/2
        }
    }
    var size: CGSize{
        get{
            return self.frame.size
        }
        set{
            var rect = self.frame
            rect.size = newValue
            self.frame = rect
        }
    }
}

extension CALayer {
    
    
    /// set Border Color
    ///
    /// - Parameter color: UIColor
    func setBorderColor(color:UIColor)  {
        self.borderColor = color.cgColor
    }
    
    
    /// set Border Width
    ///
    /// - Parameter width: Width
    func setBorderWidth(width: CGFloat)  {
        self.borderWidth = width
        self.masksToBounds = true
    }
    
    /// Set CornerRadius
    ///
    /// - Parameter radius: radius
    func setCornerRadius(radius: CGFloat)  {
        self.cornerRadius = radius
        self.masksToBounds = true
    }
    
    // MARK: - Border Setting
    func borderSet(color:UIColor, width: CGFloat = 0, radius: CGFloat = 0)  {
        self.borderColor = color.cgColor
        if width != 0 {
            self.borderWidth = width
        }
        if radius != 0 {
            self.cornerRadius = radius
            self.masksToBounds = true
        }
    }
}


@objc enum BorderType:NSInteger{
    
    case top,left,bottom,right
    
}
extension UIView{
    
    // MARK: - 为视图加上边框 ，枚举数组可以填充上下左右四个边
    @objc func addBorder(color: UIColor?, size: CGFloat, borderTypes:NSArray){
        
        var currentColor:UIColor?
        
        if let _ = color{
            currentColor = color
        }else{
            currentColor = UIColor.black
        }
        
        for borderType in borderTypes{
            let bt: NSNumber = borderType as! NSNumber
            self.addBorderLayer(color: currentColor!, size: size, boderType: BorderType(rawValue: bt.intValue)!)
        }
        
    }
    
    @objc func addBorderLayer(color: UIColor, size: CGFloat, boderType: BorderType){
        
        let layer:CALayer = CALayer()
        layer.backgroundColor = color.cgColor
        self.layer.addSublayer(layer)
        
        switch boderType{
            
        case .top:
            layer.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: size)
            
        case .left:
            layer.frame = CGRect.init(x: 0, y: 0, width: size, height: self.frame.width)
            
        case .bottom:
            layer.frame = CGRect.init(x: 0, y:self.frame.height - size, width:self.frame.width, height:size)
            
        case .right:
            layer.frame = CGRect.init(x:self.frame.width - size, y:0, width:size, height:self.frame.height)
            
        }
        
    }
    
    
    
}
