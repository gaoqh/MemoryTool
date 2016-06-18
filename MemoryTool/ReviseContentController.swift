//
//  ReviseContentController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/14.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class ReviseContentController: UIViewController {
    
    //MARK: 常量
    let searchBtnMargin: CGFloat = 15
    let searchBtnH: CGFloat = 44
    //cell标识
    let REVISE_CONTENT_CELL_ID = "revise_content_cell_id"
    //MARK: UI控件
    private var searchBtn: NoHighlightButton!
    private var headerView: UIView!
    private var tableView: UITableView!
    //数据源
    
    //MARK: 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        setNav()
        setTableView()
        setHeaderView()
        
    }
    //MARK: 设置UI
    func setNav() {
        navigationItem.title = "复习内容"
    }
    
    func setHeaderView() {
        searchBtn = NoHighlightButton(type: .Custom)
        
        searchBtn.setBackgroundImage(UIImage(named: "searchField"), forState: .Normal)
        searchBtn.layer.cornerRadius = 5
        searchBtn.setImage(UIImage(named: "search"), forState: .Normal)
        searchBtn.setTitle("搜索", forState: .Normal)
        searchBtn.titleLabel?.font = APP_FONT(14)
        searchBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5)
        searchBtn.addTarget(self, action: #selector(ReviseContentController.searchBtnClick), forControlEvents: .TouchUpInside)
        //搜索按钮
        searchBtn.x = searchBtnMargin
        searchBtn.width = SCREENW - searchBtnMargin * 2
        searchBtn.centerY = NavigationH - StatusBarH
        searchBtn.height = searchBtnH
        
        tableView.tableHeaderView = searchBtn
    }

    func setTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH - NavigationH), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        //        tableView.sectionHeaderHeight = 36
        tableView.separatorStyle = .None
        //给tableView注册一个cell
        tableView.registerClass(ReviseContentCell.self, forCellReuseIdentifier: REVISE_CONTENT_CELL_ID)
        
        //设置cell的分割线使其从最左边开始绘制
        if tableView.respondsToSelector(Selector("setSeparatorInset:")) {
            tableView.separatorInset = UIEdgeInsetsZero
        }
        if tableView.respondsToSelector(Selector("setLayoutMargins:")) {
            tableView.layoutMargins = UIEdgeInsetsZero
        }

    }
    
    //MARK: - 点击事件
    //点击搜索
    func searchBtnClick() {
        
    }

}

extension ReviseContentController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(REVISE_CONTENT_CELL_ID, forIndexPath: indexPath) as! ReviseContentCell
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    //重写绘制cell的代理方法，设置cell的分割线使其从最左边开始绘制
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if cell.respondsToSelector(Selector("setSeparatorInset:")) {
            cell.separatorInset = UIEdgeInsetsZero
        }
        if cell.respondsToSelector(Selector("setLayoutMargins:")) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
    }
}
