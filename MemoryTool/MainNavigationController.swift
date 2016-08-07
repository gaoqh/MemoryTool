//
//  MainNavigationController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = Theme.ColorNavi
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: APP_FONT(15),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ]
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
            //设置导航栏和tabBar栏的背景颜色
            viewController.navigationController?.navigationBar.backgroundColor = Theme.ColorNavi
            viewController.tabBarController?.tabBar.backgroundColor = Theme.ColorNavi

            //设置返回键盘
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.item("navigationbar_back_withtext", title: "返回", target: self, action: #selector(MainNavigationController.back))
            
        }
        super.pushViewController(viewController, animated: animated)
    }

    
    func back(){
        SVProgressHUD.dismiss()
        popViewControllerAnimated(true)
        
    }

}
