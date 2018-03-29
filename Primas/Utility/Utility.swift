//
//  Utility.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    // MARK: - delay action
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    // MARK: - Get Safe Main Queue
    class func safeMainQueue(closure:@escaping ()->()) {
        if Thread.current.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
    
    // MARK: - Get Global Thread Queue
    class func globalQueue(closure:@escaping ()->()) {
        DispatchQueue.global().async(execute: closure)
    }
    
    static func getLabHeigh(
        _ labelStr: String,
        font: UIFont,
        width: CGFloat) -> CGFloat {
        let strSize = labelStr.boundingRect(
            with: CGSize(width: width, height: 10000),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil)
        return strSize.height
    }
        
    static func getLabWidth(
        _ labelStr:String,
        font:UIFont,
        height:CGFloat) -> CGFloat {
        let strSize = labelStr.boundingRect(
            with: CGSize(width: kScreenW, height: height),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedStringKey.font: font],
            context: nil)
        return strSize.width
    }
    
    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
    // Get keyboard Height
    static func getKeyboardHeight() -> CGFloat {
        if IS_iPhone8 {
            if #available(iOS 11.0, *) { return 216 }
            return 258
        } else if IS_iPhone8P {
            return 271
        } else if IS_iPhoneX {
            return 298
        } else if IS_iPhoneSE {
            return 253
        } else {
            return 216
        }
    }
    // MARK: - Get Current timeStamp
    class func currentTimeStamp() -> String {
        //获取当前时间
        let now = NSDate()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        //当前时间的时间戳
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return String(timeStamp)
    }
    
    // MARK: - Get Array Data from plist
    class func initArrayFromPlist(plist:String) -> NSArray {
        var path:String!
        path = DeviceInfo.localizedBundle().path(forResource: plist, ofType: "plist")
        if path == nil {
            path = Bundle.main.path(forResource: plist, ofType: "plist")
        }
        let array = NSArray.init(contentsOfFile: path!)
        return array!
    }
    
    // MARK: - Get Dictionary Data from plist
    class func initDicFromPlist(plist:String) -> NSDictionary{
        var path:String!
        path = DeviceInfo.localizedBundle().path(forResource: plist, ofType: "plist")
        if path == nil {
            path = Bundle.main.path(forResource: plist, ofType: "plist")
        }
        let dict = NSDictionary.init(contentsOfFile: path!)
        return dict!
    }
    
    // MARK: - GET LanguageName by languae code
    class func getLanguageName(byCode:String) -> String {
        let dic:NSDictionary = Utility.initDicFromPlist(plist: LANGUAGE_NAME)
        let string:String = dic[byCode] as! String
        return string
    }
    
    // MARK: - set root viewcontroller
    static func resetRootViewController()  {
        let vc = Rstoryboard.main.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
    
    // MARK: - emptyKit Attributed title
    static func emptyAttributed(_ str: String) -> NSAttributedString {
        let title = str
        let font = UIFont.boldSystemFont(ofSize: 14)
        let attributes: [NSAttributedStringKey : Any] = [.foregroundColor: Color_B3B3B3, .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    static func decimalHanlder() -> NSDecimalNumberHandler {
        let roundUp = NSDecimalNumberHandler.init(roundingMode: .down,
                                                  scale: 3,
                                                  raiseOnExactness: false,
                                                  raiseOnOverflow: false,
                                                  raiseOnUnderflow: false,
                                                  raiseOnDivideByZero: true)
        return  roundUp
    }
    
    // MARK: - Get random img
    static func randomImg() -> UIImage {
        let num = Int(arc4random() % 20) + 1
        let imageName = "pic_" + String(num)
        return UIImage.init(named: imageName)!
    }
    
    // MARK: - Get random Avatar
    static func randomAvatar() -> UIImage {
        let num = Int(arc4random() % 22) + 1
        let imageName = "touxiang_" + String(num)
        return UIImage.init(named: imageName)!
    }
}
