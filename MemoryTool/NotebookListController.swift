//
//  NotebookListController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/19.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD
//首页cell标识
private let noteTypeCellId = "note_type_cell_id"

class NotebookListController: BaseViewController {
    //MARK: - 属性
    private var userId: String!
    private var tableView: UITableView!
    private lazy var modelArray: [Note] = [Note]()
    //MARK: - 构造（析构）方法
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.ColorAppBackground
        setNav()
        setTableView()
        loadData()
    }
    
    //MARK: - 设置UI
    //设置导航条
    private func setNav(){
        navigationItem.title = "笔记本"
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "新建", target: self, action: #selector(NotebookListController.addNotebook))
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "编辑", target: self, action: #selector(NotebookListController.editNotebook))
    }
    
    private func setTableView(){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH - NavigationH - TabBarH), style: UITableViewStyle.Plain)
        tableView.backgroundColor = Theme.ColorAppBackground
        tableView.separatorStyle = .SingleLine
        tableView.separatorColor = Theme.ColorAppBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
    }
    //MARK: - 点击事件
    func addNotebook() {
        let vc = AddNotebookController(initType: InitType.New, saveHandler: { [weak self] in
            self!.loadData()
            }, order: String(modelArray.count))
        let nav = MainNavigationController(rootViewController: vc)
        presentViewController(nav, animated: true, completion: nil)
    }
    func editNotebook() {
        
    }
    
    //MARK: - 加载数据
    func loadData() {
        let model = ReqNoteList(userId: AppInfo.getUserId()!)
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteList,params: params, success: { result in
            ResNoteList.mj_setupObjectClassInArray({ () -> [NSObject : AnyObject]! in
                ["list":Note.self]
            })
            let model = ResNoteList.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                self.modelArray = model.list!
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
                break
            case "1":
                SVProgressHUD.showInfoWithStatus("用户名密码不能为空")
            case "2":
                SVProgressHUD.showErrorWithStatus("登录失败")
            default:break
            }
        }) { (error) in
            
        }
    }

    func deleteCell(index: Int) {
        let cellModel = modelArray[index]
        let model = ReqNoteDelete(id: cellModel.id!)
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteDelete,params: params, success: { result in
            let model = ResModelResult.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                SVProgressHUD.showInfoWithStatus("删除成功")
                self.modelArray.removeAtIndex(index)
                self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
                break
            case "1":
                SVProgressHUD.showInfoWithStatus("删除失败")
            default:break
            }
        }) { (error) in
            
        }
    }

}

// MARK: - Table view data source TableViewDelegate
extension NotebookListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(noteTypeCellId) as? NoteTypeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("NoteTypeCell", owner: nil, options: nil).last as? NoteTypeCell
        }
        cell!.model = modelArray[indexPath.row]
        return cell!
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
    //MARK: - 滑动删除
    //先要设Cell可编辑
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //定义编辑样式
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let actionRename = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "重命名") { (action, indexPath1) in
            tableView.setEditing(false, animated: true)
            let model = self.modelArray[indexPath.row]
            let vc = AddNotebookController(initType: InitType.Rename, saveHandler: { [weak self] in
                self!.loadData()
                }, order: String(indexPath.row), noteId: model.id!, typeName: model.typeName!)
            let nav = MainNavigationController(rootViewController: vc)
            self.presentViewController(nav, animated: true, completion: nil)
        }
        let actionDelete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "删除") { (action, indexPath1) in
            UIAlertController.anyAlertViewShow("是否删除", controller: self, okHandler: { (action) in
                tableView.setEditing(false, animated: true)
                self.deleteCell(indexPath.row)
            }, cancelHandler:
                { (action) in
                tableView.setEditing(false, animated: true)
            })
        }
        return [actionDelete, actionRename]
    }

    
}
