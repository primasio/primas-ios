//
//  UIImage.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/11/6.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    // MARK: - Get UIImage By Color
    ///
    /// - Parameter color: color
    /// - Returns: UIImage instance
    
    class func createImage(_ color: UIColor, width: CGFloat = 1.0, height:CGFloat = 1.0) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: width, height: width)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor);
        context.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - keep UIImage alwaysOriginal
    func original() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
}


extension UIImage {
    
    func scaledImage(withSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    func scaleImageToFitSize(size: CGSize) -> UIImage {
        let aspect = self.size.width / self.size.height
        if size.width / aspect <= size.height {
            return scaledImage(withSize: CGSize(width: size.width, height: size.width / aspect))
        } else {
            return scaledImage(withSize: CGSize(width: size.height * aspect, height: size.height))
        }
    }    
}

