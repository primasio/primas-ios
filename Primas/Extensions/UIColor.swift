//
//  UIColor.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Get color by r, g, b, a
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff,
                  green: (netHex >> 8) & 0xff,
                  blue: netHex & 0xff)
    }
    
    // MARK: - Get color by hex string
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    // MARK: - Get Random Color
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green,
                           blue: blue, alpha: 1.0)
        }
    }
    
    static  func getColorFrom(_ f: UIColor, _ to: UIColor, _ p: CGFloat) -> UIColor {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0
        f.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        var tr:CGFloat=0, tg:CGFloat=0, tb:CGFloat=0, ta:CGFloat=0
        to.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)
        
        let lr = tr - r
        let lg = tg - g
        let lb = tb - b
        let la = ta - a
        
        let p = min(p, 1)
        r = r + lr*p
        g = g + lg*p
        b = b + lb*p
        a = a + la*p
        
        let color = UIColor.init(red: r, green: g, blue: b, alpha: a)
        return color
    }
}

