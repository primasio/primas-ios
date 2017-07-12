//
//  Extensions.swift
//  Primas
//
//  Created by wang on 10/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import Foundation

public enum Iconfont: String {
    case add = "\u{e900}"
    case arrow_left = "\u{e901}"
    case at = "\u{e902}"
    case good = "\u{e903}"
    case group = "\u{e904}"
    case pen = "\u{e905}"
    case popular = "\u{e906}"
    case pucture = "\u{e907}"
    case rights = "\u{e908}"
    case search = "\u{e909}"
    case icon_self = "\u{e90a}"
    case share = "\u{e90b}"
    case smile = "\u{e90c}"
    case value = "\u{e910}"
}

public extension UIFont {
    public class func iconfont(ofSize: CGFloat) -> UIFont? {
        if (UIFont.fontNames(forFamilyName: "ybicon").count == 0) {
            print("font not found.")
        }
        
        return UIFont(name: "ybicon", size: ofSize)!
    }
}

public extension UIImage {
    public convenience init?(text: Iconfont, fontSize: CGFloat, imageSize: CGSize = CGSize.zero, imageColor: UIColor = UIColor.black) {
        guard let iconfont = UIFont.iconfont(ofSize: fontSize) else {
            self.init()
            return nil
        }
        var imageRect = CGRect(origin: CGPoint.zero, size: imageSize)
        if __CGSizeEqualToSize(imageSize, CGSize.zero) {
            imageRect = CGRect(origin: CGPoint.zero, size: text.rawValue.size(attributes: [NSFontAttributeName: iconfont]))
        }
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        text.rawValue.draw(in: imageRect, withAttributes: [NSFontAttributeName : iconfont, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: imageColor])
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return nil
        }
        self.init(cgImage: cgImage)
    }   
}
