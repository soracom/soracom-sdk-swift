// Keychain.swift Created by mason on 2016-02-21. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation
import Security


/// Simplest possible wrapper for keychain read/write. (Be aware that this **overwrites** any existing value for key when it writes, by design).

open class Keychain {
    
    /// Find and return a blob of data previously stored under `key` using this class's `write()` method. Returns nil if not found. This is the primitive read method.
    
    open static func read(_ key: String) -> Data? {
        guard key != "" else {
            return nil; // because actually querying with empty string key returns something weird
        }
        
        let query: [String:Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        
        if status == errSecSuccess {
            if let data = dataTypeRef as! Data? {
                return data
            }
        }
        return nil
    }
    
    
    /// Store `data` to the Keychain, under `key`, **overwriting** any existing value. Returns true on success, false on error. This is the primitive write method.
    
    open static func write(_ key: String, data: Data) -> Bool {
        let query: [String:Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        
        let deleteResult = SecItemDelete(query as CFDictionary)
        if deleteResult != noErr && deleteResult != errSecItemNotFound {
            // not found is a normal occurence
            
            print("delete keychain item failed: \(deleteResult)")
            #if os(OSX)
                print(SecCopyErrorMessageString(deleteResult, nil))
                // Mason 2016-04-18: I am seeing -25244 "Invalid attempt to change the owner of this item" during unit tests.
                // Some debuggery reveals that this is because the SDK unit tests are being run by multiple different
                // apps, but the tests use the same keychain keys. This is not something this simple Keychain wrapper supports.
                // I fixed this in the tests by uniquing the keys per-app, but am leaving this note for posterity.
            #endif
            // Mason 2016-08-17: After Swift 3 / Xcode 8 upgrade, now getting -34018 in iOS Simulator... :-(
            // more info: http://stackoverflow.com/questions/22082996/testing-the-keychain-osstatus-error-34018
            // FIXME: need to solve this but I am punting for now...
        }
        
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        
        return status == noErr
    }
    
    
    /// Delete the blob of data stored under `key`, if any.
    
    open static func delete(_ key: String) -> Bool {
        let query: [String:Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
    
    
    /// Convenience method to read a UTF-8 string.
    
    open static func readString(_ key: String) -> String? {
        if let data = read(key), let stringValue = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            return stringValue as String
        } else {
            return nil
        }
    }
    
    
    /// Convenience method to write a UTF-8 string.
    
    open static func writeString(_ key: String, string: String) -> Bool {
        if let data = string.data(using: String.Encoding.utf8) {
            return write(key, data: data)
        } else {
            return false
        }
    }
    
}

// Thanks, Obama: https://gist.github.com/jackreichert/414623731241c95f0e20
