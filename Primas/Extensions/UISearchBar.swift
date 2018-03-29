//
//  UISearchBar.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    /// set clear backgroud
    func setClear() {
        let image = UIImage.createImage(UIColor.clear,
                                        width: self.bounds.size.width,
                                        height: self.bounds.size.height)
        self.backgroundColor = UIColor.clear
        self.backgroundImage = image
        self.setSearchFieldBackgroundImage(image, for: .normal)
    }
    
    /// set textfiled color
    func setTextfiled(color: UIColor)  {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = color
    }
    
    /// set textfiled font size
    func setTextfiled(fontSize:CGFloat)  {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.font = UIFont.systemFont(ofSize: fontSize)
    }
    /// set placelabel fontsize
    func setPlaceLabel(fontSize:CGFloat) {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let  textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
}
