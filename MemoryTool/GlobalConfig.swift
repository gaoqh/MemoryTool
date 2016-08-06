//
//  GlobalConfig.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/9.
//  Copyright © 2016年 高庆华. All rights reserved.
//
//本文件用于配置全局参数

import Foundation
import UIKit

/// 顶部导航条高度
public let NavigationH: CGFloat = 64
public let StatusBarH: CGFloat = 20
/// 底部tabBar高度
public let TabBarH: CGFloat = 49
/// 屏幕宽度
public let SCREENW = UIScreen.mainScreen().bounds.size.width
/// 屏幕高度
public let SCREENH = UIScreen.mainScreen().bounds.size.height
/// 屏幕三围
public let SCREENBOUNDS = UIScreen.mainScreen().bounds
/// 主题颜色
public let APP_COLOR_STATUSBAR = UIColor.whiteColor()
/// 首页导航条颜色
public let homeColor = RGB(r: 255, g: 255, b: 255, alpha: 3)

public func APP_FONT(fontSize: CGFloat) -> UIFont{
    return UIFont(name: "PingFang TC", size: fontSize)!
}
/// 主题
struct Theme {
    static let ColorNavi = UIColor(rgb: 0x2d2e3b)
    static let ColorNaviTitleGreen = UIColor(rgb: 0x00ebb5)
    static let ColorAppBackground = UIColor(rgb: 0x353542)
    static let ColorCell = UIColor(rgb: 0x3f3f4d)
    static let ColorPlaceholder = UIColor(rgb: 0x888890)
    static let ColorCellText = UIColor(rgb: 0xffffff)
    static let ColorCellDetail = UIColor(rgb: 0xa7a7ae)
}
//登录注册找回密码模块的大按钮宽度和屏幕宽度
let btnWRatio: CGFloat = 584 / 750
let btnHRatio: CGFloat = 90 / 1334

let kImageCountLimit = 12

