//
//  UIAlertControllerExtensions.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/7.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import Foundation

extension UIAlertController {
    class func anyAlertViewShow(title:String,controller:UIViewController,okHandler: ((UIAlertAction) -> Void)?, cancelHandler:((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: "",
                                                message: title, preferredStyle: UIAlertControllerStyle.Alert)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: cancelHandler)
        let okAction = UIAlertAction(title: "确认", style: UIAlertActionStyle.Default,
                                     handler: okHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
}