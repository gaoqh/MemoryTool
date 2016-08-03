//
//  NetWorkTool.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/26.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum NetWorkToolRequestType: String {
    case GET = "GET"
    case POST = "POST"
}

struct NetWorkToolConstant {
    /// 测试
    static var REQUEST_URL: String = "http://182.92.97.47:8080/mr"
    
    static let login: String = "/user/login.shtml"
}



class NetWorkTool: NSObject {
    //如果想让controller直接通过我这个类去请求网络数据的
    //当前请求成功的闭包类型:  (result: [String: AnyObject])->()
    class func request(type: NetWorkToolRequestType,url: String=NetWorkToolConstant.REQUEST_URL, transactionType: String, params: [String: AnyObject]?,accessToken: Bool = true , success:((result: String) -> Void), failure:(error: NSError)->Void) {
        
        //定义一个请求成功之后的闭包
        
        let successCallBack = {(dataTask: NSURLSessionDataTask, result: AnyObject) -> Void in
            
            /// 如果是字典
            if let res = (result as? [String: AnyObject]) {
                //把数据回调回去
               
            }else{
                //如果数据类型不对,回调错误信息->自定义的信息
        
            }
            
        }
        
        /// 定义了一个请求失败的闭包
        let failureCallBack = { (dataTask: NSURLSessionDataTask, error: NSError) -> Void in
            //回调请求失败
            failure(error: error)
        }
        
        
        //发起请求
        
        if type == .GET {
            //发送get请求
            Alamofire.request(.GET, url + transactionType, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString{response in
                if let errorCode = response.result.error?.code {
                    SVProgressHUD.showInfoWithStatus("请检查网络设置", maskType: .Clear)
                    log.info("网络错误，error:\(errorCode)")
                }else {
                    success(result: response.result.value!)
                    log.info(response.result.value!)
                }
            }
        }else{
            //发送Post请求
//            manager.POST(url, parameters: params, success: successCallBack, failure: failureCallBack)
        }
        
        //        manager.GET(url, parameters: params, success: { (dataTask, result) -> Void in
        //
        //            /// 如果是字典
        //            if let res = (result as? [String: AnyObject]) {
        //                //把数据回调回去
        //                success(result: res)
        //            }else{
        //                //如果数据类型不对,回调错误信息->自定义的信息
        //                failure(error: NSError(domain: "com.itcast.weibo", code: 10001, userInfo: ["errorMsg": "The type of result isn't [String: AnyObject]"]))
        //            }
        //        }) { (dataTask, error) -> Void in
        //            //回调请求失败
        //            failure(error: error)
        //        }
    }
    
    class func toRequestParams(model: NSObject) -> String{
        return ""
    }
}
