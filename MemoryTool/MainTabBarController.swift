//
//  MainTabBarController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/6.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        addChildViewController(HomeViewController(), title: "复习", imageName: "search", index: 0)
        addChildViewController(NotebookListController(), title: "笔记本", imageName: "search", index: 1)
        addChildViewController(HomeViewController(), title: "我", imageName: "search", index: 2)
    }

    ///添加子控制器
    private func addChildViewController(childController: UIViewController,title: String,imageName: String, index: Int) {
        
        childController.tabBarItem.title = title
        //设置偏移量，解决把图片放在tabBar中间的问题
        childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        //UIImageRenderingMode --> 渲染模式
        //设置图片
        childController.tabBarItem.image = UIImage(named: imageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        childController.tabBarItem.tag = index
        //MARK:图片名称待替换
        //选中
        childController.tabBarItem.selectedImage = UIImage(named: "\(imageName)")?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)
        //文字颜色的属性
        let textColorAttr = [
            NSForegroundColorAttributeName: UIColor.orangeColor()
        ]
        //设置选中文字颜色
        childController.tabBarItem.setTitleTextAttributes(textColorAttr, forState: UIControlState.Selected)
        
        //初始化导航控制器
        let nav = MainNavigationController(rootViewController: childController)
        
        addChildViewController(nav)
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        switch viewController.tabBarItem.tag {
        case 0:break
        case 1:
            if let userId = AppInfo.getUserId() {
                return true
            }else {
                presentViewController(MainNavigationController(rootViewController: LoginViewController(loginHandler: {
                    tabBarController.selectedIndex = 1
                })), animated: true, completion: nil)
                return false
            }
        case 2:
            if let userId = AppInfo.getUserId() {
                return true
            }else {
                presentViewController(MainNavigationController(rootViewController: LoginViewController(loginHandler: { 
                    tabBarController.selectedIndex = 2
                })), animated: true, completion: nil)
                return false
            }
        default:break
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
