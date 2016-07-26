//
//  FindPwdViewController2.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/24.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD

class FindPwdViewController2:  BaseViewController{
    
    private var email: String?
    //MARK: - 构造方法
    init(email: String) {
        super.init(nibName: nil, bundle: nil)
        self.email = email
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
        tipLabel2.text = email
        accountField.becomeFirstResponder()
    }
    
    //MARK: - 设置UI
    func setNav() {
        navigationItem.title = "找回密码"
    }
    
    func setUI() {
        edgesForExtendedLayout = .None
        //添加子控件
        view.addSubview(tipLabel1)
        view.addSubview(tipLabel2)
        view.addSubview(accountView)
        view.addSubview(accountField)
        view.addSubview(findPwdBtn)
        
    }
    
    func setConstraint() {
        tipLabel1.snp_makeConstraints { (make) in
            make.top.equalTo(59)
            make.centerX.equalTo(0)
            make.width.equalTo(SCREENW)
        }
        tipLabel2.snp_makeConstraints { (make) in
            make.top.equalTo(tipLabel1.snp_bottom).offset(19)
            make.centerX.equalTo(0)
            make.width.equalTo(SCREENW)
        }
        accountView.snp_makeConstraints { (make) in
            make.top.equalTo(tipLabel2.snp_bottom).offset(60)
            make.left.right.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(46)
        }
        accountField.snp_makeConstraints { (make) in
            make.left.equalTo(27)
            make.centerY.equalTo(accountView)
            make.right.equalTo(-27)
        }
        findPwdBtn.snp_makeConstraints { (make) in
            make.top.equalTo(accountView.snp_bottom).offset(57)
            make.width.equalTo(SCREENW * btnWRatio)
            make.height.equalTo(SCREENH * btnHRatio)
            make.centerX.equalTo(0)
        }
    }
    
    //MARK: - 懒加载子控件
    private lazy var tipLabel1: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.text = "我们已发送一个验证码至"
        label.textColor = UIColor(rgb: 0x888890)
        label.font = APP_FONT(14)
        return label
    }()
    private lazy var tipLabel2: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor(rgb: 0x888890)
        label.font = APP_FONT(14)
        return label
    }()
    private lazy var accountView: UIView = {
        let label = UIView()
        label.backgroundColor = Theme.ColorCell
        return label
    }()
    private lazy var accountField: UITextField = {
        let label = UITextField()
        label.keyboardType = UIKeyboardType.NumberPad
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(14)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "填写收到的验证码"
        return label
    }()
    private lazy var findPwdBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.Custom)
        btn.setTitle("验证", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(rgb: 0x353542), forState: UIControlState.Normal)
        btn.titleLabel?.font = APP_FONT(16)
        btn.setBackgroundImage(UIImage(named: ImageName.loginBtn), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: ImageName.loginBtn_highlighted), forState: UIControlState.Highlighted)
        btn.addTarget(self, action: #selector(FindPwdViewController2.findPwdBtnClick), forControlEvents: .TouchUpInside)
        return btn
    }()
    //MARK: - 点击事件
    
    func findPwdBtnClick(){
        
        if accountField.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("验证码不能为空", maskType: .Clear)
        } else if !accountField.text!.isPureFloat() {
            SVProgressHUD.showInfoWithStatus("验证码格式不正确", maskType: .Clear)
        }else {
            navigationController?.pushViewController(FindPwdViewController3(), animated: true)
            
        }
    }
    
    func hideKeyboard() {
        accountField.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        hideKeyboard()
    }



}
