//
//  Notebook.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/23.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
//MARK: - 请求
class ReqNoteList: NSObject {
    var userId: String?
    
    init(userId: String) {
        self.userId = userId
    }
}
class ReqNoteSave: NSObject {
    var userId: String?
    var typeName: String?
    var order: String?
    
    init(userId: String, typeName: String, order: String) {
        self.userId = userId
        self.typeName = typeName
        self.order = order
    }
}
class ReqNoteDelete: NSObject {
    var userId: String?
    
    init(userId: String) {
        self.userId = userId
    }
}
class ReqNoteUpdate: NSObject {
    var userId: String?
    
    init(userId: String) {
        self.userId = userId
    }
}


//MARK: - 响应
