//
//  HomeViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/9.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import XCGLogger

class HomeViewController: UIViewController {
    //MARK: - 属性
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        configUI()
    }
    //MARK: - 设置UI
    func setNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "今日", target: self, action: Selector("leftItemClick"))
    }
    
    func configUI() {
        view.backgroundColor = UIColor.whiteColor()
    }
    //MARK: - 点击事件
    func leftItemClick() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
