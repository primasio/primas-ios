//
//  String.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/18.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // MARK: -  Returns true if self has 0x prefix
    public func has0xPrefix() -> Bool {
        return hasPrefix("0x") || hasPrefix("0X")
    }
    
    // MARK: -  remove 0x or 0X
    public func remove0xPrefix() -> String {
        var hex = self
        if has0xPrefix() {
            hex = String(hex.dropFirst(2))
        }
        return hex
    }

    // MARK: -  insert striing afterEvery index
    func insert(seperator: String, afterEvery: Int) -> String {
        var output = ""
        self.enumerated().forEach { index, c in
            if index % afterEvery == 0 && index > 0 {
                output += seperator
            }
            output.append(c)
        }
        return String(output)
    }
    
    // MARK: - RemoveAllSapce  " "
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ",
                                         with: "",
                                         options: .literal,
                                         range: nil)
    }
    
    // MARK: -  Judge self contain other String
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    // MARK: - Num String To NSDecimalNumber instance
    func toDecimalNumber() -> NSDecimalNumber {
        return NSDecimalNumber.init(string: self)
    }
    
    // MARK: - substring to from
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    // MARK: - substring with range
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    

    // MARK: -  get localized String
    var localized: String {
        return NSLocalizedString(self,
                                 tableName: LANGUAGE_TABLE_PLIST,
                                 bundle: DeviceInfo.localizedBundle(),
                                 value: "",
                                 comment: "")
    }
    // MARK: - string to data
    func toData(_ using: String.Encoding = .utf8) -> Data {
        return self.data(using: using)!
    }
    
    // MARK: - hanlde string show date
    func toTimeString() -> String {
        
        guard !self.isEmpty else {  return "" }
        
        let time = Date().timeIntervalSince1970
        let timeInterval = Int(time) - Int(self)!
        var result = ""
        
        if timeInterval / 60 < 1 {
            result = Rstring.time_just_ago.localized()
        } else if  timeInterval / 60 < 60 {
            result = String.init(format: Rstring.time_min_ago.localized(),timeInterval / 60 )
        } else if timeInterval / (60 * 60) < 24 {
            result = String.init(format: Rstring.time_hour_ago.localized(), timeInterval / (60 * 60))
        } else if timeInterval / (60 * 60 * 24) < 30 {
            result = String.init(format: Rstring.time_day_ago.localized(), timeInterval / (60 * 60 * 24))
        } else if timeInterval / (60 * 60 * 24 * 30) < 12 {
            result = String.init(format: Rstring.time_hour_ago.localized(), timeInterval / (60 * 60 * 24 * 30))
        } else  {
           // result = String.init(format: Rstring.time_year_ago.localized(), timeInterval / (60 * 60 * 24 * 30 * 12))
            let dfmatter = DateFormatter()
            dfmatter.dateFormat="yyyy-MM-dd HH:mm:ss"
            let date = dfmatter.date(from: self)
            let dateStamp = date!.timeIntervalSince1970
            let dateSt:Int = Int(dateStamp)
            result = String(dateSt)
        }
        return result
    }

    // MARK: - transfor pst value
    func toPstValue() -> String {
        guard !self.isEmpty else { return "" }
        let value = NSDecimalNumber.init(string: self)
        let ratio = NSDecimalNumber.init(string: PST_RATIO)
        let result = value.dividing(by: ratio, withBehavior: Utility.decimalHanlder()).stringValue
        return result
    }

    // MARK: - replace \n
    func replaceReturn() -> String {
       return self.replace(of: "\\n", with: "\r\n")
    }
}


// 字符串类扩展
extension String {
    
    /// 获取字符串绘制的高度
    ///
    /// - parameter font        : 要绘制的字体，将会影响行高等
    /// - parameter width       : 绘制的宽度
    /// - returns : 字符串绘制的最大高度
    func getMaxHeight(font:UIFont, width:CGFloat) -> CGFloat {
        // 获取最大的
        let s = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let size = getMaxHeight(font: font, rangeRect: s)
        return CGFloat(ceil(Double(size.height)))
    }
    
    func getMaxWidth(font:UIFont, height:CGFloat) -> CGFloat {
        // 获取最大的
        let s = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let size = getMaxHeight(font: font, rangeRect: s)
        return CGFloat(ceil(Double(size.width)))
    }
    
    /// 获取字符串绘制的高度
    ///
    /// - parameter font        : 要绘制的字体，将会影响行高等
    /// - parameter rangeRect   : 绘制的最大范围，类似于最大的画布
    /// - returns : 字符串绘制的最大高度
    func getMaxHeight(font:UIFont, rangeRect rect:CGSize) -> CGSize {
        // draw option
        let opt:NSStringDrawingOptions = [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin]
        // str
        let str = NSString(string: self)
        // max size
        let maxSize = rect
        // font
        let attr:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font : font]
        // 计算出来的范围
        let resultRect = str.boundingRect(with: maxSize, options: opt, attributes: attr, context: nil)
        return resultRect.size
        // 返回高度
        //return CGFloat(ceil(Double(resultRect.height)))
    }
    
    /**
     获取字符串的单行宽度,
     有可能会超过屏幕限制
     - parameter font : 要绘制的字体
     */
    func getMaxWidth(font:UIFont) -> CGFloat {
        let opt:NSStringDrawingOptions = [NSStringDrawingOptions.truncatesLastVisibleLine, NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin]
        // str
        let str = NSString(string: self)
        // max size
        let maxSize = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        // font
        let attr:[NSAttributedStringKey:Any] = [NSAttributedStringKey.font : font]
        // 计算出来的范围
        let resultRect = str.boundingRect(with: maxSize, options: opt, attributes: attr, context: nil)
        // 返回高度
        return CGFloat(ceil(Double(resultRect.width)))
    }
    
    /**
     去除左右的空格和换行符
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     将字符串通过特定的字符串拆分为字符串数组
     - parameter str   : 拆分数组使用的字符串
     - returns : 字符串数组
     */
    func split(string:String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
    
    /**
     拆分字符串，并获取指定索引的字符串
     - parameter splitStr   : 拆分数组使用的字符串
     - parameter index      : 索引位置
     - parameter defaultStr : 默认字符串
     - returns : 拆分所得字符串
     */
    func strSplitByIndex(splitStr str:String, index:Int, defaultStr:String = "") -> String {
        let a = self.split(string:str)
        if index > a.count - 1  {
            return defaultStr
        }
        return a[index]
    }
    
    /**
     字符串替换
     - parameter of     : 被替换的字符串
     - parameter with   : 替换使用的字符串
     - returns : 替换后的字符串
     */
    func replace(of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    /**
     判断是否包含，虽然系统提供了方法，这里也只是简单的封装。如果swift再次升级的话，就知道现在做的好处了
     - parameter string : 是否包含的字符串
     - returns : 是否包含
     */
    func has(string:String) -> Bool {
        return self.contains(string)
    }
    
    /**
     字符出现的位置
     - parameter string : 字符串
     - returns : 字符串出现的位置
     */
    func indexOf(string str:String) -> Int {
        var i = -1
        if let r = range(of: str) {
            if !r.isEmpty {
                i = self.distance(from: self.startIndex, to: r.lowerBound)
            }
        }
        return i
    }
    
    /**
     这个太经典了,获取指定位置和大小的字符串
     - parameter start  : 起始位置
     - parameter length : 长度
     - returns : 字符串
     */
    func subString(start:Int, length:Int) -> String {
        if start + length > self.count { return "" }
        let s = index(startIndex, offsetBy: start)
        let e = index(s, offsetBy: length)
        return String(self[s ..< e])
    }

    /// 字符串的长度
    var length:Int {
        get {
            return self.count
        }
    }
    
    /// 将16进制字符串转为Int
    var hexInt:Int {
        get {
            return Int(self, radix: 16) ?? 0
        }
    }
    
    static func dateNow() -> String {
        
        let nowDate = Date()
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let date = formatter.string(from: nowDate)
        return date.components(separatedBy: " ").first!
    }
    
    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }

}
