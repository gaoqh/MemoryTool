//
//  DBTestViewController.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/10.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class DBTestViewController: UIViewController {

    //数据库
    var db : SQLiteDB!
    //TODO: 临时的控件
    private var txtUname: UITextField!
    private var txtMobile: UITextField!
    private var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表（其中uid为自增主键）
        db.execute("create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
        //如果有数据则加载
        initUser()
        
        view.backgroundColor = UIColor.whiteColor()
        
        txtUname = UITextField(frame: CGRect(x: 100, y: 100, width: 150, height: 44))
        txtUname.backgroundColor = UIColor.grayColor()
        view.addSubview(txtUname)
        txtMobile = UITextField(frame: CGRect(x: 100, y: 200, width: 150, height: 44))
        txtMobile.backgroundColor = UIColor.grayColor()
        view.addSubview(txtMobile)
        
        saveBtn = UIButton(frame: CGRect(x: 100, y: 300, width: 150, height: 44))
        view.addSubview(saveBtn)
        saveBtn.backgroundColor = UIColor.blueColor()
        saveBtn.addTarget(self, action: #selector(DBTestViewController.saveUser), forControlEvents: .TouchUpInside)
        saveBtn.setTitle("保存", forState: .Normal)
    }

    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from t_user")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1]
            txtUname.text = user["uname"] as? String
            txtMobile.text = user["mobile"] as? String
        }
    }
    
    //保存数据到SQLite
    func saveUser() {
        let uname = self.txtUname.text!
        let mobile = self.txtMobile.text!
        //插入数据库，这里用到了esc字符编码函数，其实是调用bridge.m实现的
        let sql = "insert into t_user(uname,mobile) values('\(uname)','\(mobile)')"
        print("sql: \(sql)")
        //通过封装的方法执行sql
        let result = db.execute(sql)
        print(result)
    }
    

    

}
