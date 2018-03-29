//
//  UILabel.swift
//  Primas
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

extension UILabel {

    func heightFitWith() -> CGFloat {
        return text?.getMaxHeight(font: font, width: width) ?? 0.0
    }

    func widthFitHeight() -> CGFloat {
        return text?.getMaxWidth(font: font, height: height) ?? 0.0
    }
}

extension UIButton {
    func titleWidth() -> CGFloat {
        if titleLabel != nil {
            return titleLabel!.widthFitHeight()
        }
        return 0.0
    }
    
}
