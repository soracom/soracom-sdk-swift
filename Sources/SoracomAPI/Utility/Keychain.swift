// Keychain.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc.. All rights reserved.

import Foundation

#if os(Linux)
    // The Security framework is not available on Linux.
    public typealias OSStatus = Int32
#else
    import Security
#endif


/// Simplest possible wrapper for keychain read/write. (Be aware that this **overwrites** any existing value for a key when it writes, by design). On macOS and iOS, this uses the OS-provided secure storage facility to store data blobs.
///
/// LINUX NOTE: On Linux, this is a very(!) primitive data store that does NOT actually provide any security. It reads/writes blobs to a folder, in plaintext. So the Linux version is currently a "keychain" in the sense of a keychain with a bunch of labeled keys, left lying on a desk in plain sight. In the future, we will at least support reading credentials from environment variables on Linux. See:  [issue 5](https://github.com/soracom/soracom-sdk-swift/issues/5)


open class Keychain {
    
    // The "insecure plain text" read/write methods are for Linux, but they are available on all platforms.
    
    
    /// Normally, `Keychain` will use secure persistent storage if available (macOS & iOS) and use insecure plaintext storage only when no secure mechanism is available (Linux). But, this property can be set to `true` to force Keychain to always use insecure storage — the main use case for =that being testing/debugging Linux code on non-Linux platforms.
    
    public static var useInsecurePlaintextStorageAlways = false
    
    
    /// Returns a file URL pointing to ~/.soracom-sdk-swift, which is where plaintext data gets stored.
    
    public static func urlToInsecurePlaintextStorage() -> URL {
        
        let fm  = FileManager.default
        let pathToHome = NSHomeDirectory();

        #if !os(Linux)
            let urlToHome = NSURL.fileURL(withPath: pathToHome)
        #else
            // NSURL.fileURL(withPath:) does not exist on Linux (a bug, as of Swift 4.2 convergence 2018-08-08)
            guard let urlToHome = NSURL.fileURL(withPathComponents: [pathToHome]) else {
                fatalError("Keychain: fatal error: cannot get URL to home directory: \(pathToHome)")
            }
        #endif

        let url = urlToHome.appendingPathComponent(".soracom-sdk-swift")
        
        do {
            try fm.createDirectory(at: url, withIntermediateDirectories: true)
        } catch {
            fatalError("Keychain: fatal error: cannot create directory: \(url)")
        }
        return url
    }
    
    
    /// Find and return a blob of data previously stored under `key` using this class's `writeToInsecurePlaintextStorage()` method. Returns nil if not found. This is the primitive read method when `Keychain` is in "insecure plain text" mode (normally, this would only be on Linux, where secure storage isn't yet supported). Note that keys should be globally unique to avoid clashing with other apps that might use this Keychain implementation.
    
    public static func readFromInsecurePlaintextStorage(_ key: String) -> Data? {
        
        let uniqueKey = makeUnique(key);
        
        do {
            let url = self.urlToInsecurePlaintextStorage().appendingPathComponent(uniqueKey)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    
    /// Store `data` to the "insecure plain text" mode persistent store, under `key`, **overwriting** any existing value. Returns true on success, false on error. This is the primitive write method when `Keychain` is in "insecure plain text" mode (normally, this would only be on Linux, where secure storage isn't yet supported).
    
    public static func writeToInsecurePlaintextStorage(_ key: String, data: Data) -> Bool {
        
        let uniqueKey = makeUnique(key);
        
        do {
            let url = self.urlToInsecurePlaintextStorage().appendingPathComponent(uniqueKey)
            try data.write(to: url)
            return true
        } catch {
            return false
        }
    }
    
    
    /// Delete the blob of data stored under `key` in the "insecure plain text" mode persistent store, if any.
    
    public static func deleteFromInsecurePlaintextStorage(_ key: String) -> Bool {
        
        let uniqueKey = makeUnique(key);
        
        let fm  = FileManager.default
        let url = self.urlToInsecurePlaintextStorage().appendingPathComponent(uniqueKey)
        
        guard fm.fileExists(atPath: url.path) else {
            return false
        }
        do {
            try fm.removeItem(at: url)
            return true
        } catch {
            return false
        }
    }


    #if os(Linux)
    
    
    /// Find and return a blob of data previously stored under `key` using this class's `write()` method. Returns nil if not found. This is the primitive read method. Note that keys should be globally unique to avoid clashing with other apps that might use this Keychain implementation.

        public static func read(_ key: String) -> Data? {
            
            return readFromInsecurePlaintextStorage(key)
        }
    
    
        /// Store `data` to the persistent store, under `key`, **overwriting** any existing value. Returns true on success, false on error. This is the primitive write method.

        public static func write(_ key: String, data: Data) -> Bool {
            
            return writeToInsecurePlaintextStorage(key, data: data)
        }
    
        
        /// Delete the blob of data stored under `key`, if any.

        public static func delete(_ key: String) -> Bool {
            
            return deleteFromInsecurePlaintextStorage(key)
        }
    
    #elseif os(macOS) || os(iOS)
        
        /// Find and return a blob of data previously stored under `key` using this class's `write()` method. Returns nil if not found. This is the primitive read method.
        
    public static func read(_ key: String) -> Data? {
            
            if (useInsecurePlaintextStorageAlways) {
                
                return readFromInsecurePlaintextStorage(key)
            }
            
            let uniqueKey = makeUnique(key);

            guard uniqueKey != "" else {
                return nil; // because actually querying with empty string key returns something weird
            }
            
            let query: [String:Any] = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrAccount as String : uniqueKey,
                kSecReturnData as String  : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne
            ]
            
            var dataTypeRef: AnyObject?
            let status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
            
            if status == errSecSuccess {
                if let data = dataTypeRef as! Data? {
                    return data
                }
            } else if status == errSecItemNotFound {
                // don't log this by default, even if logging is on; it's an expected condition in many circumstances
            } else {
                errorLogger(status, "read item \(uniqueKey)")
            }
            return nil
        }
        
        
        /// Store `data` to the persistent store, under `key`, **overwriting** any existing value. Returns true on success, false on error. This is the primitive write method.
        
    public static func write(_ key: String, data: Data) -> Bool {
            
            if (useInsecurePlaintextStorageAlways) {
                
                return writeToInsecurePlaintextStorage(key, data: data)
            }

            let uniqueKey = makeUnique(key);

            let query: [String:Any] = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : uniqueKey,
                kSecValueData as String   : data
            ]
            
            let deleteResult = SecItemDelete(query as CFDictionary)
            if deleteResult != noErr && deleteResult != errSecItemNotFound {
                // not found is a normal occurence
                
                errorLogger(deleteResult, "delete/overwrite item \(uniqueKey)")
                
                #if os(OSX)
                    let errMessage = SecCopyErrorMessageString(deleteResult, nil)
                    errorLogger(deleteResult, "error description: \(String(describing: errMessage))")
                    
                    // Mason 2016-04-18: I am seeing -25244 "Invalid attempt to change the owner of this item" during unit tests.
                    // Some debuggery reveals that this is because the SDK unit tests are being run by multiple different
                    // apps, but the tests use the same keychain keys. This is not something this simple Keychain wrapper supports.
                    // I fixed this in the tests by uniquing the keys per-app, but am leaving this note for posterity.
                #endif
                
                if deleteResult == -34018 {
                    
                    if NSClassFromString("XCTest") != nil {
                        let gameOverMan = [
                            "💀 SOMEBODY SET US UP THE XCODE BOMB.",
                            "💀 Sadly, this sucks. Xcode has an issue.",
                            "💀 This may help: https://forums.developer.apple.com/thread/4743.",
                            "💀 (find for 'Mason' in that thread). TL;DR: enable Keychain Sharing",
                            "💀 entitlement for your main app, even if you don't need it.",
                            "💀 Please file a bug with Apple if this happens on your machine...",
                            ].joined(separator: "\n")
                        
                        fatalError(gameOverMan)
                    }
                }
            }
            
            let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
            
            if status != noErr && status != errSecItemNotFound {
                errorLogger(status, "add item \(uniqueKey)")
            }
            return status == noErr
        }
        
        
        /// Delete the blob of data stored under `key`, if any.
        
    public static func delete(_ key: String) -> Bool {
            
            if (useInsecurePlaintextStorageAlways) {
                
                return deleteFromInsecurePlaintextStorage(key)
            }

            let uniqueKey = makeUnique(key);
            
            let query: [String:Any] = [
                kSecClass as String       : kSecClassGenericPassword,
                kSecAttrAccount as String : uniqueKey
            ]
            
            let status: OSStatus = SecItemDelete(query as CFDictionary)
            
            if status != noErr && status != errSecItemNotFound {
                errorLogger(status, "delete item \(uniqueKey)")
            }
            
            return status == noErr
        }
    
        // Thanks, Obama: https://gist.github.com/jackreichert/414623731241c95f0e20
    
    #endif
}


extension Keychain {
    
    /// Convenience method to read a UTF-8 string.
    
    public static func readString(_ key: String) -> String? {
        if let data = read(key), let stringValue = String(data: data, encoding: .utf8) {
            return stringValue
        } else {
            return nil
        }
    }
    
    
    /// Convenience method to write a UTF-8 string.
    
    public static func writeString(_ key: String, string: String) -> Bool {
        if let data = string.data(using: String.Encoding.utf8) {
            return write(key, data: data)
        } else {
            return false
        }
    }
    
    
    /// Because Keychain in OS X and iOS has had some gnarly-ass bugs over the years, and still might, log errors. This default logger just uses print() but you can replace it with your own logger if you want.
    
    static var errorLogger: KeychainErrorLogger = {
        
        (_ errCode: OSStatus, _ whenTryingTo: String ) in
        
        var errCodeDescription = ""
        #if os(OSX)
            print(SecCopyErrorMessageString(errCode, nil) ?? "SecCopyErrorMessageString() couldn't return the error message.")
        #endif
        
        print("KEYCHAIN ERROR: An error occurred when trying to \(whenTryingTo): \(errCode)")
          // Mason 2016-08-17: I don't know of a reliable way to go from errCode to the corresponding symbol name on iOS.
    }
    

    public typealias KeychainErrorLogger = ((_ errCode: OSStatus, _ whenTryingTo: String ) -> Void)
        
    
    public static func makeUnique(_ key: String) -> String {
        return storageIdentifier + "." + key;
    }

    
    /// Because the actual underlying persistent store may be shared between apps, each app should have its own globally unique storage identifier. Typically, this should be set once, during app launch (but this can be skipped if you already have a unique bundle ID). The keys under which data is stored will have this identifier prepended to them, to ensure keys are globally unique. That way they keys passed to the read(), write(), and delete() methods need only be unique within the app.
    
    public static var storageIdentifier: String {
        
        get {
            return _storageIdentifier 
                ?? Bundle.main.bundleIdentifier
                ?? missingStorageIdentifier
        }
        set {
            _storageIdentifier = newValue
        }
    }
    internal static var _storageIdentifier: String? = nil

    
    /// In the case of no storage identifier (which is a coding error), this string will be used
    
    public static let missingStorageIdentifier = "missing-storage-identifier"
}
