//
//  Macro.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

// MARK: -  Screen size
let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

// MARK: -  abbreviation
let X_Notification = NotificationCenter.default
let X_UserDefaults = UserDefaults.standard
let Rstring = R.string.language.self
let Rimage = R.image.self
let Rstoryboard = R.storyboard.self
let Rnib = R.nib.self
let RreuseIdentifier = R.reuseIdentifier.self
let Rcolor = R.clr.primasColor.self


// MARK: - Typealias
typealias NoneBlock   = ()->()
typealias StringBlock = (_ pwd: String)->()
typealias errorBlock  = (_ error: Error)->()
typealias arrayBlock  = (_ error: [Any])->()

// MARK: - iPhone deviece
/// iPhone X
let IS_iPhoneX  = (UIScreen.main.bounds.size.width == 375
                 && UIScreen.main.bounds.size.height == 812)
/// iPhone 8 (4.7 inch)
let IS_iPhone8  = UIScreen.main.bounds.size.height == 667
/// iPhone 8P (5.5 inch)
let IS_iPhone8P = UIScreen.main.bounds.size.height == 736
/// iPhone SE (4.0 inch)
let IS_iPhoneSE =  UIScreen.main.bounds.size.height == 568
