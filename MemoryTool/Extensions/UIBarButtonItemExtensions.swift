//
//  UIBarButtonItemExtensions.swift
//  DiamondClient
//
//  Created by gaoqinghua on 15/12/2.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func item(imageName: String = "", title: String = "", target: AnyObject?, action: Selector) -> UIBarButtonItem {
        //初始化一个button
        let button = UIButton()
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        //判断是否有title
        if title.characters.count>0 {
            //设置文字以及字体颜色,以及字体大小
            button.setTitle(title, forState: UIControlState.Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(16)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            //高亮的颜色
            button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        }
        
        if imageName.characters.count>0 {
            
            //设置button的不同状态的图片
            button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
            //高亮的图片
            button.setImage(UIImage(named: String(imageName) + "_highlighted"), forState: UIControlState.Highlighted)
        }
        //调整大小
        button.sizeToFit()
        
        return UIBarButtonItem(customView: button)
    }
    
}