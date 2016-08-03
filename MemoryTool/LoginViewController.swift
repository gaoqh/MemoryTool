//
//  LoginViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/24.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class LoginViewController: BaseViewController {
    
    private let leftMargin: CGFloat = SCREENW * (1-btnWRatio) * 0.5
    //登录之后执行的闭包
    var loginHandler: (() -> Void)?
    //MARK: - 构造方法
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    init(loginHandler: (() -> Void)?) {
        super.init(nibName: nil, bundle: nil)
        self.loginHandler = loginHandler
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
        navigationItem.title = "登录"
        navigationItem.leftBarButtonItem = UIBarButtonItem.item("", title: "返回", target: self, action: #selector(LoginViewController.cancel))
    }

    func setUI() {
        edgesForExtendedLayout = .None
        //添加子控件
        view.addSubview(iconView)
        view.addSubview(accountLabel)
        view.addSubview(accountField)
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(pwdLabel)
        view.addSubview(pwdField)
        view.addSubview(loginBtn)
        view.addSubview(noAccountLabel)
        view.addSubview(registerBtn)
        view.addSubview(findPwdBtn)
    }
    
    func setConstraint() {
        iconView.snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(0)
            make.width.height.equalTo(120)
        }
        accountLabel.snp_makeConstraints { (make) in
            make.top.equalTo(218)
            make.left.equalTo(leftMargin)
            make.width.equalTo(32)
        }
        accountField.snp_makeConstraints { (make) in
            make.left.equalTo(accountLabel.snp_right).offset(21)
            make.centerY.equalTo(accountLabel)
            make.right.equalTo(-leftMargin)
        }
        line1.snp_makeConstraints { (make) in
            make.top.equalTo(accountLabel.snp_bottom).offset(24)
            make.left.equalTo(leftMargin)
            make.right.equalTo(-leftMargin)
            make.height.equalTo(0.5)
        }
        line2.snp_makeConstraints { (make) in
            make.top.equalTo(line1.snp_bottom).offset(60)
            make.left.equalTo(leftMargin)
            make.right.equalTo(-leftMargin)
            make.height.equalTo(0.5)
        }
        pwdLabel.snp_makeConstraints { (make) in
            make.top.equalTo(line1.snp_bottom).offset(21)
            make.left.equalTo(accountLabel)
        }
        pwdField.snp_makeConstraints { (make) in
            make.left.equalTo(accountField)
            make.centerY.equalTo(pwdLabel)
            make.right.equalTo(-leftMargin)
        }
        loginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(line2.snp_bottom).offset(57)
            make.width.equalTo(SCREENW * btnWRatio)
            make.height.equalTo(SCREENH * btnHRatio)
            make.centerX.equalTo(0)
        }
        noAccountLabel.snp_makeConstraints { (make) in
            make.top.equalTo(loginBtn.snp_bottom).offset(22)
            make.centerX.equalTo(-10)
            make.width.equalTo(96)
        }
        registerBtn.snp_makeConstraints { (make) in
            make.left.equalTo(noAccountLabel.snp_right).offset(-3)
            make.centerY.equalTo(noAccountLabel)
            make.width.equalTo(32)
        }
        findPwdBtn.snp_makeConstraints { (make) in
            make.top.equalTo(noAccountLabel.snp_bottom).offset(36)
            make.centerX.equalTo(0)
        }
    }
    
    //MARK: - 懒加载子控件
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "homeAdd"))
        return imageView
    }()
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(15)
        label.text = "账号"
        label.sizeToFit()
        return label
    }()
    private lazy var accountField: UITextField = {
        let label = UITextField()
        label.keyboardType = .EmailAddress
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(15)
//        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
//        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "输入已注册邮箱"
        label.clearButtonMode = .WhileEditing
        return label
    }()
    private lazy var line1: UIImageView = {
        let label = UIImageView(image: UIImage(named: ImageName.login_line))
        return label
    }()
    private lazy var pwdLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(15)
        label.text = "密码"
        return label
    }()
    private lazy var pwdField: UITextField = {
        let label = UITextField()
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(15)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "填写密码"
        label.clearButtonMode = .WhileEditing
        label.secureTextEntry = true
        return label
    }()
    private lazy var line2: UIView = {
        let label = UIImageView(image: UIImage(named: ImageName.login_line))
        return label
    }()
    private lazy var loginBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(rgb: 0x353542), forState: UIControlState.Normal)
        btn.titleLabel?.font = APP_FONT(16)
        btn.setBackgroundImage(UIImage(named: ImageName.loginBtn), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: ImageName.loginBtn_highlighted), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: #selector(LoginViewController.loginBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xa7a7ae)
        label.font = APP_FONT(15)
        label.text = "没有账号，去"
        return label
    }()
    private lazy var registerBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(rgb: 0xafe5a57), forState: UIControlState.Normal)
        btn.titleLabel?.font = APP_FONT(15)
        btn.addTarget(self, action: #selector(LoginViewController.registerBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    private lazy var findPwdBtn: UIButton = {
        let btn = UIButton(type: .Custom)
        btn.setTitle("忘记密码？", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(rgb: 0x888890), forState: UIControlState.Normal)
        btn.titleLabel?.font = APP_FONT(13)
        btn.addTarget(self, action: #selector(LoginViewController.findPwdBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    //MARK: - 点击事件
    func cancel() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    func registerBtnClick() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    func findPwdBtnClick() {
        navigationController?.pushViewController(FindPwdViewController(), animated: true)
    }
    func loginBtnClick(){
        
        if accountField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("邮箱不能为空", maskType: .Clear)
        } else if pwdField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("密码不能为空", maskType: .Clear)
        } else if !accountField.text!.validateEmail() {
            SVProgressHUD.showInfoWithStatus("邮箱格式不正确", maskType: .Clear)
        }else {
            loadData()
//            SVProgressHUD.showSuccessWithStatus("登录成功", maskType: .Clear)
//            navigationController?.dismissViewControllerAnimated(true, completion: {
//                if self.loginHandler != nil {
//                    self.loginHandler!()
//                }
//            })
        }
    }
    
    func hideKeyboard() {
        accountField.resignFirstResponder()
        pwdField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        hideKeyboard()
    }
    
    //MARK: - 加载数据
    func loadData() {
        let model = ReqLoginModel(userName: accountField.text!, passWord: pwdField.text!)
        let params: NSDictionary = model.mj_keyValues()
        let dict = params as! [String: AnyObject]
        log.severe("\(params)")
        NetWorkTool.request(NetWorkToolRequestType.GET, transactionType: NetWorkToolConstant.login,params: dict, success: { result in
            log.debug(result)
            }) { (error) in
                
        }
    }
    
    //MARK: - 处理数据

}
