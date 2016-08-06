//
//  LoginModel.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/3.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
//MARK: - 请求
class ReqLoginModel: NSObject {
    var userName: String?
    var passWord: String?
    
    init(userName: String, passWord: String) {
        self.userName = userName
        self.passWord = passWord
    }
    
}

class ReqRegisterModel: NSObject {
    var userName: String?
    var passWord: String?
    
    init(userName: String, passWord: String) {
        self.userName = userName
        self.passWord = passWord
    }
    
}

class ReqUpdatePwdModel: NSObject {
    var userName: String?
    var passWord: String?
    var newPassWord: String?
    
    init(userName: String, passWord: String, newPassWord: String) {
        self.userName = userName
        self.passWord = passWord
        self.newPassWord = newPassWord
    }
    
}

//MARK: - 响应
class ResLoginModel: NSObject {
    var result: String?
    var userId: String?
    
}

class ResRegisterModel: NSObject {
    var result: String?
    
}

class ResUpdatePwdModel: NSObject {
    var result: String?
    
}
