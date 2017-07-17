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
    case primas_icon = "\u{e903}"
    case exclamatory = "\u{e904}"
    case praise_off = "\u{e905}"
    case praise_on = "\u{e906}"
    case group = "\u{e907}"
    case pen = "\u{e908}"
    case ph = "\u{e909}"
    case popular = "\u{e90a}"
    case pucture = "\u{e90b}"
    case transfer = "\u{e90c}"
    case search = "\u{e90d}"
    case icon_self = "\u{e90e}"
    case share = "\u{e90f}"
    case smile = "\u{e910}"
    case trend = "\u{e914}"
    case icon_type = "\u{e915}"
    case value = "\u{e916}"
    case setting = "\u{e917}"
    case closed = "\u{e919}"
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
