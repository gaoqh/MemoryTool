//
//  MainNavigationController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count>0 {
            
            //设置导航栏和tabBar栏的背景颜色
            viewController.navigationController?.navigationBar.backgroundColor = APP_COLOR_STATUSBAR
            viewController.tabBarController?.tabBar.backgroundColor = APP_COLOR_STATUSBAR

            //设置返回键盘
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.item("navigationbar_back_withtext", title: "", target: self, action: #selector(MainNavigationController.back))
            
        }
        super.pushViewController(viewController, animated: animated)
    }

    
    func back(){
        
        popViewControllerAnimated(true)
        
    }

}
