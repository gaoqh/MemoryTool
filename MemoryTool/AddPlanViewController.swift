//
//  AddPlanViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/10.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SnapKit
import FMDB

let ADD_PLAN_CELL_ID = "add_plan_cell_id"

class AddPlanViewController: UIViewController {
    
    //MARK: - UI控件
    private var mainScrollView: UIScrollView!
    private var numberOfLines: Int = 1
    //MARK: - 属性
    private var reviseTitle: String!
    private var reviseContents: [String]!
    //复习频率
    private var reviseFreq: String!
    //MARK: - 数据库
    var dataBase: FMDatabase!
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        configUI()
        openDataBase()
        
    }
    //MARK: - 构造（析构）方法

    //MARK: - 设置UI
    func setNav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "取消", target: self, action: #selector(AddPlanViewController.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "确定", target: self, action: #selector(AddPlanViewController.finish))
    }
    
    func configUI() {
        view.backgroundColor = UIColor.lightGrayColor()
        automaticallyAdjustsScrollViewInsets = false
        mainScrollView = UIScrollView()
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(mainScrollView)
        mainScrollView.alwaysBounceVertical = true
        mainScrollView.backgroundColor = UIColor.whiteColor()
        
        mainScrollView.addSubview(titleField)
        
    }
    
    //MARK: - 懒加载子控件
    private lazy var titleField: UITextField = {
        let field = UITextField(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 44))
        field.setLeftViewMode(UITextFieldLeftViewMode.Space)
        field.backgroundColor = UIColor.whiteColor()
        field.textColor = UIColor.lightGrayColor()
        field.font = UIFont.systemFontOfSize(14)
        field.placeholder = "标题："
        return field
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView.separatorStyle = .SingleLine
        tableView.rowHeight = 64
        tableView.registerClass(AddPlanCell.self, forCellReuseIdentifier: ADD_PLAN_CELL_ID)
        
        return tableView
    }()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("新增", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.addTarget(self, action: #selector(AddPlanViewController.addBtnClick), forControlEvents: .TouchUpInside)
        return btn
    }()
    //MARK: - 启动数据库
    func openDataBase() {
        let documents = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        let fileURL = documents.URLByAppendingPathComponent("test.sqlite")
        
        dataBase = FMDatabase(path: fileURL.path)
        
        let success = dataBase.open()
        if success {
            log.info("数据库创建成功！")
            let str = "CREATE TABLE IF NOT EXISTS t_test (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, score REAL NOT NULL)"
            if dataBase.executeUpdate(str, withArgumentsInArray: nil) {
                log.info("表创建成功")
            }else {
                log.error("表创建失败")
            }
        }else {
            log.error("数据库创建失败")
        }
        
    }
    //MARK: - 点击事件
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func finish() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addBtnClick() {
        numberOfLines += 1
        tableView.reloadData()
    }


}

extension AddPlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfLines
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ADD_PLAN_CELL_ID, forIndexPath: indexPath) as! AddPlanCell
        cell.selectionStyle = .None
        cell.contentTextField.text = String(indexPath.row + 1)
        
        return cell
    }
}
