//
//  DeviceInfo.swift
//  DiamondClient
//
//  Created by mac on 15/12/15.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation

public class AppInfo {
    public static var appVersion: String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    }

    public static func sharedContainerIdentifier() -> String? {
        if let baseBundleIdentifier = AppInfo.baseBundleIdentifier() {
            return "group." + baseBundleIdentifier
        }
        return nil
    }

    public static func keychainAccessGroupWithPrefix(prefix: String) -> String? {
        if let baseBundleIdentifier = AppInfo.baseBundleIdentifier() {
            return prefix + "." + baseBundleIdentifier
        }
        return nil
    }

    public static func baseBundleIdentifier() -> String? {
        let bundle = NSBundle.mainBundle()
        if let packageType = bundle.objectForInfoDictionaryKey("CFBundlePackageType") as? NSString {
            if let baseBundleIdentifier = bundle.bundleIdentifier {
                if packageType == "XPC!" {
                    let components = baseBundleIdentifier.componentsSeparatedByString(".")
                    return components[0..<components.count-1].joinWithSeparator(".")
                }
                return baseBundleIdentifier
            }
        }
        return nil
    }
    private static var messageID:Int64 = 1000
    public static var getMessageID:Int64 {
        
        return (++messageID)
        
    }
    private static var token:String = ""
    
    public static func setToken(t : String){
     self.token = t
    }
    public static func getToken() -> String{
        return self.token
    }
    
}