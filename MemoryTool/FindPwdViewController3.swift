//
//  FindPwdViewController3.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/24.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import SVProgressHUD

class FindPwdViewController3:  BaseViewController{
    
    //MARK: - 构造方法
    
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setUI()
        setConstraint()
        newPwdField1.becomeFirstResponder()
    }
    
    //MARK: - 设置UI
    func setNav() {
        navigationItem.title = "找回密码"
    }
    
    func setUI() {
        edgesForExtendedLayout = .None
        //添加子控件
        view.addSubview(newPwdView1)
        view.addSubview(newPwdField1)
        view.addSubview(newPwdView2)
        view.addSubview(newPwdField2)
        view.addSubview(finishBtn)
        
    }
    
    func setConstraint() {
        newPwdView1.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalTo(0)
            make.width.equalTo(SCREENW)
            make.height.equalTo(46)
        }
        newPwdField1.snp_makeConstraints { (make) in
            make.left.equalTo(27)
            make.centerY.equalTo(newPwdView1)
            make.right.equalTo(-27)
        }
        newPwdView2.snp_makeConstraints { (make) in
            make.top.equalTo(newPwdView1.snp_bottom).offset(1)
            make.left.right.equalTo(newPwdView1)
            make.height.equalTo(46)
        }
        newPwdField2.snp_makeConstraints { (make) in
            make.left.right.equalTo(newPwdField1)
            make.centerY.equalTo(newPwdView2)
        }
        finishBtn.snp_makeConstraints { (make) in
            make.top.equalTo(newPwdView2.snp_bottom).offset(57)
            make.width.equalTo(SCREENW * btnWRatio)
            make.height.equalTo(SCREENH * btnHRatio)
            make.centerX.equalTo(0)
        }
    }
    
    //MARK: - 懒加载子控件
    private lazy var newPwdView1: UIView = {
        let label = UIView()
        label.backgroundColor = Theme.ColorCell
        return label
    }()
    private lazy var newPwdField1: UITextField = {
        let label = UITextField()
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(14)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "填写新密码"
        return label
    }()
    private lazy var newPwdView2: UIView = {
        let label = UIView()
        label.backgroundColor = Theme.ColorCell
        return label
    }()
    private lazy var newPwdField2: UITextField = {
        let label = UITextField()
        label.textColor = UIColor(rgb: 0xb5b5ba)
        label.font = APP_FONT(14)
        label.setValue(UIColor(rgb: 0x888890), forKeyPath: "_placeholderLabel.textColor")
        label.setValue(APP_FONT(13), forKeyPath: "_placeholderLabel.font")
        label.placeholder = "确认新密码"
        return label
    }()
    private lazy var finishBtn: UIButton = {
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
        if newPwdField1.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("密码不能为空", maskType: .Clear)
        } else if newPwdField2.text!.isEmpty {
            SVProgressHUD.showInfoWithStatus("密码不能为空", maskType: .Clear)
        }
        navigationController?.popToRootViewControllerAnimated(true)

    }
    
    func hideKeyboard() {
        newPwdField1.resignFirstResponder()
        newPwdField2.resignFirstResponder()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        hideKeyboard()
    }

}
