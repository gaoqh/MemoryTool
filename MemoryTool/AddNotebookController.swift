//
//  AddNotebookController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/6.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD

enum InitType: Int {
    case New = 0
    case Rename = 1
}

class AddNotebookController: BaseViewController {
    //MARK: - 属性
    //登录之后执行的闭包
    private var saveHandler: (() -> Void)?
    private var order: String?
    private var noteId: String?
    private var typeName: String?
    private var initType: InitType = .New
    //MARK: - 构造方法
    init(initType: InitType, saveHandler: (() -> Void)?, order: String, noteId: String = "", typeName: String = "") {
        super.init(nibName: nil, bundle: nil)
        self.saveHandler = saveHandler
        self.order = order
        self.initType = initType
        self.noteId = noteId
        self.typeName = typeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setUI()
        setConstraint()
        
    }
    //MARK: - 设置UI
    func setNav() {
        switch initType {
        case InitType.New:
            navigationItem.title = "新建笔记本"
            navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "保存",color: Theme.ColorNaviTitleGreen, target: self, action: #selector(AddNotebookController.saveClick))
        case InitType.Rename:
            navigationItem.title = "重命名"
            navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "确定",color: Theme.ColorNaviTitleGreen, target: self, action: #selector(AddNotebookController.renameClick))
        default:break
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "取消", target: self, action: #selector(AddNotebookController.cancel))
    }
    
    func setUI() {
        edgesForExtendedLayout = .None
        //添加子控件
        view.addSubview(nameView)
        view.addSubview(nameField)
    }
    
    func setConstraint() {
        nameView.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(47)
        }
        nameField.snp_makeConstraints { (make) in
            make.left.equalTo(27)
            make.centerY.equalTo(nameView)
            make.right.equalTo(-27)
        }
    }
    
    //MARK: - 懒加载子控件
    private lazy var nameView: UIView = {
        let label = UIView()
        label.backgroundColor = Theme.ColorCell
        return label
    }()
    private lazy var nameField: UITextField = {
        let label = UITextField()
        if self.initType == .Rename {
            label.text = self.typeName
        }
        label.clearButtonMode = .WhileEditing
        label.keyboardType = UIKeyboardType.EmailAddress
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(14)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "输入名称..."
        return label
    }()

    //MARK: - 点击事件
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func saveClick(){
        
        if nameField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("不能为空", maskType: .Clear)
        }else {
            if let userId = AppInfo.getUserId() {
                loadData(userId)
            }
            
        }
    }
    func renameClick() {
        if nameField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("不能为空", maskType: .Clear)
        }else {
            loadRenameData()
        }
    }
    
    func loadData(userId: String) {
        let model = ReqNoteSave(userId: userId, typeName: nameField.text!, order: order!)
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteSave,params: params, success: { result in
            let model = ResModelResult.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                SVProgressHUD.showSuccessWithStatus("添加成功")
                self.dismissViewControllerAnimated(true, completion: {
                    if let handler = self.saveHandler {
                        handler()
                    }
                })

            case "1":
                SVProgressHUD.showInfoWithStatus("添加失败")
            default:break
            }
        }) { (error) in
            
        }
    }

    func loadRenameData() {
        let model = ReqNoteUpdate(id: noteId!, typeName: nameField.text!, order: order!)
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteUpdate,params: params, success: { result in
            let model = ResModelResult.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                SVProgressHUD.showSuccessWithStatus("修改成功")
                self.dismissViewControllerAnimated(true, completion: { 
                    if let handler = self.saveHandler {
                        handler()
                    }
                })
            case "1":
                SVProgressHUD.showInfoWithStatus("添加失败")
            default:break
            }
        }) { (error) in
            
        }
    }

    
    func hideKeyboard() {
        nameField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        hideKeyboard()
    }


}
