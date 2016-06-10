//
//  Logger.swift
//  DiamondClient
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation
import XCGLogger

public struct Logger {}

// MARK: ---log写入指定文件
public extension Logger {
    
    static let logPII = false
    
    static let homeLogger: XCGLogger = Logger.fileLoggerWithName("home")
    
    static let saleLogger: XCGLogger = Logger.fileLoggerWithName("sale")
    
    static let profileLogger: XCGLogger = Logger.fileLoggerWithName("profile")
    
    static let otherLogger: XCGLogger = Logger.fileLoggerWithName("other")
    
    
    //MARK---you can add your need files
    static func logFileDirectoryPath() -> String? {
        if let cacheDir = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first {
            let logDir = "\(cacheDir)/Logs"
            if !NSFileManager.defaultManager().fileExistsAtPath(logDir) {
                do {
                    try NSFileManager.defaultManager().createDirectoryAtPath(logDir, withIntermediateDirectories: false, attributes: nil)
                    return logDir
                } catch _ as NSError {
                    return nil
                }
            } else {
                return logDir
            }
        }
        
        return nil
    }
    
    static private func fileLoggerWithName(filename: String) -> XCGLogger {
        let log = XCGLogger()
        if let logDir = Logger.logFileDirectoryPath() {
            let fileDestination = XCGFileLogDestination(owner: log, writeToFile: "\(logDir)/\(filename).log", identifier: "com.hiersun.dimondclient.filelogger.\(filename)")
            log.addLogDestination(fileDestination)
        }
        return log
    }
}