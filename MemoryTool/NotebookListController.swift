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
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.showsVerticalScrollIndicator = false
        //给tableView注册一个cell
        tableView.registerClass(NoteTypeCell.self, forCellReuseIdentifier: noteTypeCellId)
        view.addSubview(tableView)
    }
    //MARK: - 点击事件
    func back() {
        
    }
    func addNotebook() {
        navigationController?.pushViewController(AddNotebookController(saveHandler:{ [weak self] in
            self!.loadData()
            }), animated: true)
    }
    func editNotebook() {
        
    }
    
    //MARK: - 加载数据
    func loadData() {
        let model = ReqNoteList(userId: AppInfo.getUserId()!)
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteList,params: params, success: { result in
            let model = ResNoteList.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                self.modelArray = model.list!
                self.tableView.reloadData()
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


}

// MARK: - Table view data source TableViewDelegate
extension NotebookListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(noteTypeCellId, forIndexPath: indexPath) as! NoteTypeCell
        cell.model = modelArray[indexPath.row]
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
