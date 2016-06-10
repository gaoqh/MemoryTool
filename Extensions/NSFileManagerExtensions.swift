//
//  NSFileManagerExtensions.swift
//  DiamondClient
//
//  Created by mac on 15/12/1.
//  Copyright © 2015年 hiersun. All rights reserved.
//

import Foundation

public let NSFileManagerExtensionsDomain = "org.hiersun.NSFileManagerExtensions"

public enum NSFileManagerExtensionsErrorCodes: Int {
    case EnumeratorFailure = 0
    case EnumeratorElementNotURL = 1
    case ErrorEnumeratingDirectory = 2
}

public extension NSFileManager {
    private func directoryEnumeratorForURL(url: NSURL) throws -> NSDirectoryEnumerator {
        let prefetchedProperties = [
            NSURLIsRegularFileKey,
            NSURLFileAllocatedSizeKey,
            NSURLTotalFileAllocatedSizeKey
        ]

        var enumeratorError: NSError?
        let errorHandler: (NSURL, NSError?) -> Bool = { _, error in
            enumeratorError = error
            return false
        }

        guard let directoryEnumerator = NSFileManager.defaultManager().enumeratorAtURL(url,
            includingPropertiesForKeys: prefetchedProperties,
            options: [],
            errorHandler: errorHandler) else {
            throw errorWithCode(.EnumeratorFailure)
        }

        if let _ = enumeratorError {
            throw errorWithCode(.ErrorEnumeratingDirectory, underlyingError: enumeratorError)
        }

        return directoryEnumerator
    }

    private func sizeForItemURL(url: AnyObject, withPrefix prefix: String) throws -> Int64 {
        guard let itemURL = url as? NSURL else {
            throw errorWithCode(.EnumeratorElementNotURL)
        }

        guard itemURL.isRegularFile && itemURL.lastComponentIsPrefixedBy(prefix) else {
            return 0
        }

        return itemURL.getResourceLongLongForKey(NSURLTotalFileAllocatedSizeKey)
            ?? itemURL.getResourceLongLongForKey(NSURLFileAllocatedSizeKey)
            ?? 0
    }

    func allocatedSizeOfDirectoryAtURL(url: NSURL, forFilesPrefixedWith prefix: String, isLargerThanBytes threshold: Int64) throws -> Bool {
        let directoryEnumerator = try directoryEnumeratorForURL(url)
        var acc: Int64 = 0
        for item in directoryEnumerator {
            acc += try sizeForItemURL(item, withPrefix: prefix)
            if acc > threshold {
                return true
            }
        }
        return false
    }
    func getAllocatedSizeOfDirectoryAtURL(url: NSURL, forFilesPrefixedWith prefix: String) throws -> Int64 {
        let directoryEnumerator = try directoryEnumeratorForURL(url)
        return try directoryEnumerator.reduce(0) {
            let size = try sizeForItemURL($1, withPrefix: prefix)
            return $0 + size
        }
    }

    private func errorWithCode(code: NSFileManagerExtensionsErrorCodes, underlyingError error: NSError? = nil) -> NSError {
        var userInfo = [String: AnyObject]()
        if let _ = error {
            userInfo[NSUnderlyingErrorKey] = error
        }

        return NSError(
            domain: NSFileManagerExtensionsDomain,
            code: code.rawValue,
            userInfo: userInfo)
    }
}