//
//  ReviseContentController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class ReviseContentController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        setNav()
    }
    
    func setNav() {
        navigationItem.title = "复习内容"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
