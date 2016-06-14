//
//  CurveSettingController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class CurveSettingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        setNav()
    }
    
    func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "自定义", target: self, action: #selector(CurveSettingController.setting))
    }
    //自定义
    func setting() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
