//
//  StringExtensions.swift
//  DiamondClient
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    public func contains(other: String) -> Bool {
        if other.isEmpty {
            return true
        }
        return self.rangeOfString(other) != nil
    }

    public func startsWith(other: String) -> Bool {
        if other.isEmpty {
            return true
        }
        if let range = self.rangeOfString(other,
                options: NSStringCompareOptions.AnchoredSearch) {
            return range.startIndex == self.startIndex
        }
        return false
    }

    public func endsWith(other: String) -> Bool {
        if other.isEmpty {
            return true
        }
        if let range = self.rangeOfString(other,
                options: [NSStringCompareOptions.AnchoredSearch, NSStringCompareOptions.BackwardsSearch]) {
            return range.endIndex == self.endIndex
        }
        return false
    }

    func escape() -> String {
        let raw: NSString = self
        let str = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
            raw,
            "[].",":/?&=;+!@#$()',*",
            CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
        return str as String
    }

    func unescape() -> String {
        let raw: NSString = self
        let str = CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, raw, "[].")
        return str as String
    }

    func ellipsize(let maxLength maxLength: Int) -> String {
        if (maxLength >= 2) && (self.characters.count > maxLength) {
            let index1 = self.startIndex.advancedBy((maxLength + 1) / 2) 
            let index2 = self.endIndex.advancedBy(maxLength / -2)

            return self.substringToIndex(index1) + "…\u{2060}" + self.substringFromIndex(index2)
        }
        return self
    }

    private var stringWithAdditionalEscaping: String {
        return self.stringByReplacingOccurrencesOfString("|", withString: "%7C", options: NSStringCompareOptions(), range: nil)
    }

    public var asURL: NSURL? {

        return NSURL(string: self) ??
               NSURL(string: self.stringWithAdditionalEscaping)
    }
    //根据字体大小计算size
    func size(font: UIFont,constrainedToSize: CGSize = CGSizeZero) -> CGSize {
        
        //转成NSString
        let string = self as NSString
        
        //初始化属性
        let attr = [
            NSFontAttributeName: font
        ]
        //调用系统的方法计算大小
        return string.boundingRectWithSize(constrainedToSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin], attributes: attr, context: nil).size
    }
    
    /// 判断是否是手机号
    public func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
    public func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
    //判断是不是6-8位数
    public func validatePassword() -> Bool {
        
        //  ^\w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
        let wordRegex: String = "^{6,8}\\w+$"
        let wordTest = NSPredicate(format: "SELF MATCHES %@", wordRegex)
        return wordTest.evaluateWithObject(self)
        
    }
    /**
     千位符+两位小数点 价格数字格式化
     
     - parameter price: 价格
     
     - returns: 格式化后的字符串
     */
    static func stringWithPrice(price:Double) -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.formatterBehavior = NSNumberFormatterBehavior.Behavior10_4
        numberFormatter.numberStyle = .CurrencyStyle
        numberFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
        let numString = numberFormatter.stringFromNumber(NSNumber(double: price))
        
        return numString!
    }
    //纯数字
    func isPureFloat() -> Bool {
        let scan = NSScanner(string: self)
        var val:Float = 0
        return scan.scanFloat(&val) && scan.atEnd
    }
}
