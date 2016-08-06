//
//  AddNotebookController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/6.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddNotebookController: BaseViewController {
    //MARK: - 属性
    //登录之后执行的闭包
    var saveHandler: (() -> Void)?
    //MARK: - 构造方法
    init(saveHandler: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        self.saveHandler = saveHandler
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
        navigationItem.title = "新建笔记本"
        navigationItem.rightBarButtonItem = UIBarButtonItem.item("", title: "保存",color: Theme.ColorNaviTitleGreen, target: self, action: #selector(AddNotebookController.saveClick))
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
        label.keyboardType = UIKeyboardType.EmailAddress
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(14)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "输入名称..."
        return label
    }()

    //MARK: - 点击事件
    
    func saveClick(){
        
        if nameField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("不能为空", maskType: .Clear)
        }else {
            if let userId = AppInfo.getUserId() {
                loadData(userId)
            }
            
        }
    }
    
    func loadData(userId: String) {
        let model = ReqNoteSave(userId: userId, typeName: nameField.text!, order: "0")
        let params = NetWorkTool.toRequestParams(model)
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.noteSave,params: params, success: { result in
            let model = ResLoginModel.mj_objectWithKeyValues(result)
            switch model.result! {
            case "0" :
                SVProgressHUD.showSuccessWithStatus("添加成功")
                self.navigationController?.popViewControllerAnimated(true)
                if let handler = self.saveHandler {
                    handler()
                }
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
