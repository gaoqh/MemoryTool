//
//  AddPlanViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/10.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SnapKit

class AddPlanViewController: UIViewController {
    
    //MARK: - 属性
    private var titleField: UITextField!
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        setNav()
        configUI()
    }
    //MARK: - 设置UI
    func setNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "取消", target: self, action: #selector(AddPlanViewController.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "确定", target: self, action: #selector(AddPlanViewController.finish))
    }
    
    func configUI() {
        view.backgroundColor = UIColor.lightGrayColor()
        
        titleField = UITextField(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 44))
        view.addSubview(titleField)
        titleField.backgroundColor = UIColor.whiteColor()
        titleField.textColor = UIColor.lightGrayColor()
        titleField.font = UIFont.systemFontOfSize(14)
        titleField.placeholder = "标题："

    }
    //MARK: - 点击事件
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func finish() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
