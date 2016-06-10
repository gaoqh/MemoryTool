//
//  NSStringExtensions.swift
//  DiamondClient
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation

extension NSString {
    public class func contentsOfFileWithResourceName(name: String, ofType type: String, fromBundle bundle: NSBundle, encoding: NSStringEncoding, error: NSErrorPointer) -> NSString? {
        if let path = bundle.pathForResource(name, ofType: type) {
            do {
                return try NSString(contentsOfFile: path, encoding: encoding)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}


