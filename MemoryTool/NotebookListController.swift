//
//  NotebookListController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/19.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class NotebookListController: UIViewController {
    //MARK: - 属性
    private var tableView: UITableView!
    private var modelArray: [Notebook]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setTableView()
    }
    
    //MARK: - 设置UI
    //设置导航条
    private func setNav(){
        navigationItem.title = "选择笔记本"
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "新建", target: self, action: #selector(NotebookListController.addNotebook))
    }
    
    private func setTableView(){
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.separatorStyle = .None
        view.addSubview(tableView)
    }
    func back() {
        
    }
    func addNotebook() {
        
    }
    

}

// MARK: - Table view data source TableViewDelegate
extension NotebookListController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section == (addressArray.count - 1){
//            return 0
//        }else{
//            return 10
//        }
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 96
//    }
//    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return addressArray.count
//    }
//    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "1236")
        
        return cell
    }
//
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if selectionHandler != nil{
//            let addressModel = addressArray[indexPath.section]
//            selectionHandler!(selectedModel: addressModel)
//            navigationController?.popViewControllerAnimated(true)
//        }
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    
}
