// Payload.swift Created by mason on 2016-03-26. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/**
 The `Payload` class represents the data payload contained by a Request or a Response. It has two purposes:
 
 - to hold a collection of values that will be sent to the API server with a request, or
 
 - to represent the collection of values received from the API server as part of a response.
 
 In most cases, client code won't need to construct payloads directly. For outgoing requests, the various convenience methods defined by `Request` create the payload under normal circumtances. And when a received from the API server, a payload is created automatically, and is available to you via the `Response` instance.
 
 Due to the original limitations of JSON in cross-platform Swift `Payload` had to be able to do conversion between native Swift objects and the various objects defined by this SDK, and basic JSON-friendly representations of those objects.
 
 Now that Swift 4 is here, though, there's a much better JSON story. So Payload's role will likely be reduced. As of right now, though, it's still the intermediate data representation between API JSON data structures, and native objects in this SDK. 
*/
public final class Payload: ExpressibleByDictionaryLiteral, PayloadConvertible, Equatable {
    
    public static func from(_ payload: Payload?) -> Payload? {
        // FIXME: this is just a hack for conformance to PayloadConvertible. FIXME: It really should be making a copy.
        return payload
    }

    
    /// Init a Payload from data (which should be UTF-8 encoded JSON).
    
    init?(data: Data?) throws {
        
        guard let data = data else {
            return nil // not an error — nil data means payload should also be nil (i.e., nonexistent)
        }
        
        guard String(data: data, encoding: String.Encoding.utf8) != nil else {
            throw PayloadDecodeError.invalidTextEncodingError
        }
        
        guard data != Data() else {
            // Mason 2016-07-01: is this an appropriate way to handle this? What are the rules governing whether we get nil or and empty NSData instance?
            rootObjectType = .foreignDictionary
            return
        }
        
        let obj = try JSONSerialization.jsonObject(with: data, options: [])
          // Because this is a big unknown blob of JSON, we don't know what we
          // are getting. JSONSerialization does seem to work well for this use
          // case. Soracom API requests/responses are all either objects or arrays. 
        
        if let dict = obj as? [String:Any] {
            
            rootObjectType = .foreignDictionary
            self.parseRootObject(dict)
            
        } else if let array = obj as? [Any] {
            
            rootObjectType = .foreignArray
            self.parseRootObject(array)
            
        } else {
            throw PayloadDecodeError.unsupportedJSONRootObjectType
        }
    }
    
    
    /// Init a Payload via a dictionary literal (common when creating payloads to send).
    
    public init(dictionaryLiteral elements: (PayloadKey, Any)...) {
        
        rootObjectType = .nativeDictionary
        
        for (k,v) in elements {
            self[k] = v
        }
    }


    /// Init with a root object that is a native array.
    
    init(list: [Any]) {
        
        rootObjectType = .nativeArray
        
        self.rootArray = list
    }
    
    
    convenience init(tagList: TagList) {
        
        var a: [Any] = []
        for t in tagList {
            a.append(t)
        }
        self.init(list: a)
    }
    
    
    convenience init(configurationParameterList: ConfigurationParameterList) {

        self.init(list: [])
        
        rootObjectType = .nativeArray
        for cp in configurationParameterList {
            self.rootArray.append(cp)
        }
        
        // Mason 2016-06-30: This is another way to solve the same compiler limitation as the "map {$0 as PayloadConvertible}" solution above.
        // FIXME 2017-07-14 (mason):
        // 1. above comment doesn't make sense; there's no "map {$0 as PayloadConvertible}" in this file
        // 2. what compiler limitation, and does it still exist
        // 3. init with FooObj belongs as an extension defined in FooObj.swift
    }
    

    /// Compliance with this one is easy.
    
    func toPayload() -> Payload {
        return self
    }

    
    /// Convenience subscript accessor. 
    
    subscript(key: PayloadKey) -> Any? {
        
        get {
            return rootDictionary[key]
        }
        
        set(newValue) {
            rootDictionary[key] = newValue
        }
    }
    
    // FIXME: add int subscript for when root object is array?

    
    // MARK: - Decoding
    
    func parseRootObject(_ dictionary: [String:Any]) {
        
        for (k,v) in dictionary {
            
            if let key = PayloadKey(rawValue: k) {
                
                self[key] = v
                
            } else {
                
                print("Payload.fromDictionary(): warning: \(k) is not a known PayloadKey value; ignoring")
                // FIXME: consider how this should really be handled.
            }
        }
    }
    
    
    func parseRootObject(_ foreignArray: [Any]) {
        
        // Mason 2016-07-01: cannot just do this:
        //     array = foreignArray
        // ...because, this may happen somtimes:
        //      fatal error: array cannot be bridged from Objective-C

        for e in foreignArray {
            rootArray.append(e)
        }
    }
    
    
    // MARK: - Encoding
    
    /// Returns a 'basic' object representation of `value` suitable for encoding as JSON. (A 'basic' value here means something NSJSONSerialization can handle.) This includes converting native objects like Subscriber or BeamStats to generic dictionaries, etc.
    
    func coerceValueToBasicType(_ oldValue: Any) -> Any? {
        
        if let newValue = oldValue as? Subscriber {
            return newValue.toPayload().toDictionary()
        }
        else if let newValue = oldValue as? PayloadConvertible {
            // A match here means that the object is one of our custom objects, e.g. an AirStats struct, that
            // knows how to serialize itself in Payload form. So we let it do that, and then recursively
            // convert the nested Payload to a dictionary:
            
            return newValue.toPayload().toDictionary()
        }
        else if let newValue = oldValue as? Int64 {

            // return NSNumber(value: newValue) 
            // Mason 2016-08-16: Still cannot use Int64 here, even with swiftlang-800.0.43.6. NSJSONSerialization will raise if you pass it Int64 to encode.
            // Mason 2017-07-14: JSONSerialization still chokes on Int64, for the record. 
            // So let's just use Int (implies we no longer support 32-bit platforms):
            
            return Int(newValue);
              // That will crash if Int is not 64-bit; but that is OK because we are dropping 32-bit support.  
            
        } else if let newValue = oldValue as? Int {
            return newValue
        } 
        else if let newValue = oldValue as? String {
            return newValue
        }
        else if let newValue = oldValue as? [String: Any] {
            return newValue
        }
        else if let newValue = oldValue as? [Any] {
            return newValue
        }
        else if let newValue = oldValue as? NSNumber {
            // FIXME: get rid of this, it's pre-Linux legacy junk
            return newValue
        }
        else if let newValue = oldValue as? NSDictionary {
            // FIXME: get rid of this, it's pre-Linux legacy junk
            return newValue
        }
        else if let newValue = oldValue as? NSArray {
            // FIXME: get rid of this, it's pre-Linux legacy junk
            return  newValue
        }
        else if oldValue is NSNull {
            return oldValue
        }
        else {
            print("oldValue is \(oldValue) and type \(String(describing: type(of: oldValue)))")
            fatalError("work in progress bro (FIXME) \(oldValue)")
            // return oldValue
        }
    }
    
    
    // Returns a 'basic' dictionary representation of the receiver, suitable for encoding as JSON, or `nil` if the receiver's `rootObjectType` is not a dictionary type. (A 'basic' value here means something NSJSONSerialization can handle.) This process converts objects conforming to `PayloadConvertible` to dictionaries containing 'basic' keys and values, using `coerceValueToBasicType()`.
    
    func toDictionary() -> [String:Any]? {
        
        // FIXME: think about renaming this. toForeignDictionary()?
        
        guard rootObjectType == .foreignDictionary || rootObjectType == .nativeDictionary else {
            return nil
        }
        
        var result: [String:Any] = [:]

        for (oldKey, oldValue) in rootDictionary {
            
            let newKey   = oldKey.stringValue
            let newValue = coerceValueToBasicType(oldValue)
            
            if newValue != nil {
                
                result[newKey] = newValue
            
            } else {
                
                print("FIXME: figure out to do when this happens: coerceValueToBasicType() returned nil for \(oldKey) / \(oldValue)")
                fatalError("coerceValueToBasicType() failed")
            }
        }
        
        return result
    }
    
    
    /// Returns a 'basic' array representation of the receiver, suitable for encoding as JSON, or `nil` if the receiver's `rootObjectType` is not an array type. (A 'basic' value here means something NSJSONSerialization can handle.) This process converts objects conforming to `PayloadConvertible` to dictionaries containing 'basic' keys and values, using `coerceValueToBasicType()`.

    func toArray() -> [Any]? {
        
        guard rootObjectType == .foreignArray || rootObjectType == .nativeArray else {
            return nil
        }
        
        var result: [Any] = []
        
        for oldValue in rootArray {
            
            if let newValue = coerceValueToBasicType(oldValue) {
                
                result.append(newValue)
                
            } else {
                
                print("FIXME: figure out to do when this happens: \(#function): coerceValueToBasicType() returned nil")
                fatalError("coerceValueToBasicType() failed")
            }
        }
        return result
    }
    

    /// Initialize and return a new Payload instance from `src`.
    
    static func fromDictionary(_ src: [String: Any]?) -> Payload? {
        
        guard let src = src else {
            return nil
        }
        
        let result = self.init()
        
        for (k,v) in src {
            
            if let key = PayloadKey(rawValue: k) {
                result[key] = v
            
            } else {
                print("Payload.fromDictionary(): warning: \(k) is not a known PayloadKey value; ignoring")
            }
        }
        return result
    }
    
    
    /// Returns its contents as a JSON UTF-8 string.
    
    func toJSON() -> String? {
        guard let d = toJSONData() else {
            return nil
        }
        let result = d.utf8String
        return result
    }
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON (as UTF-8 string). Returns `nil` if encoding fails. The main purpose of this is for encoding a payload to send to the API server with a request, but it's also useful for tests.
    
    func toJSONData() -> Data? {
        
        do {
            var obj: Any?
            
            switch rootObjectType {
                
                case .nativeDictionary:
                    obj = toDictionary()
                
                case .foreignDictionary:
                    obj = toDictionary()
                
                case .nativeArray:
                    obj = toArray()
                
                case .foreignArray:
                    obj = toArray()
            }
            
            guard let rootObj = obj else {
                throw PayloadEncodeError.jsonConversionFailed
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: rootObj, options: .prettyPrinted)
            return jsonData
            
        } catch {
            print("JSON encode error: \(error)")
            return nil 
        }
    }
    
    
    // MARK: - Private:
    
    /// The root object type is determined based on the data used to init the payload.
    
    fileprivate var rootObjectType: PayloadRootObjectType

    /// The underlying private storage (when `rootObjectType` is `.NativeDictionary` or `.ForeignDictionary`).
    
    fileprivate var rootDictionary: [PayloadKey:Any] = [:]
    
    /// The underlying private storage (when `rootObjectType` is `.NativeArray` or `.ForeignArray`).
    
    fileprivate var rootArray: [Any] = []
    
}


/// The type of the root object (top-level object) in the JSON representation. This is typically Dictionary, but sometimes will be Array. 
///
/// The `nativeXXX` types may contain Swift objects and SDK objects, as long as those are types that Payload knows how to encode as JSON-safe values. These root object types are used for Payloads originating on the client side, to be sent with an API request. Payload knows how to convert these to JSON for sending over the wire.
///
/// The 'foreignXXX' variants only contain simple values, as result from decoding JSON data into native Swift objects. These types are used when decoding responses received from the API server. Because the data formats are not self-describing, Payload cannot deserialize this data into higher-level API objects; instead that has to be delegated to the model object classes themselves. (Which means that you need to know what kind of object(s) you are trying to decode.)
///
/// (**NOTE:** So far, array and object (dictionary) are the only two fundamental types I have encountered in the HTTP message body, but I have not yet examined the entire API. As far as the design of Payload goes, it should be able to support any valid JSON root object type (a topic on which various RFCs and implementations have [different opinions](http://stackoverflow.com/questions/3833299/can-an-array-be-top-level-json-text/3833312#3833312)...). However, I am not going to actually implement support for any other types until we neeed them. )

private enum PayloadRootObjectType {
    case nativeDictionary
    case foreignDictionary
    case nativeArray
    case foreignArray
}


// MARK: - Equatable conformance

/// Computes whether `lhs` and `rhs` are equivalent.
/// 
/// This used to just be implemented by converting the Payload instances to NSDictionary, and then asking NSDictionary if they are equal, but once we added support for non-dictionary payloads, it got more complicated `(T_T)`.

public func ==(lhs: Payload, rhs: Payload) -> Bool
{
    guard lhs.rootObjectType == rhs.rootObjectType else {
        return false
    }
    
    let type = lhs.rootObjectType
    
    if type == .nativeDictionary ||  type == .foreignDictionary {
        
        let leftDict  = lhs.toDictionary()
        let rightDict = rhs.toDictionary()
        
        if leftDict == nil && rightDict == nil {
            return true
        } else {
            guard let ld = leftDict, let rd = rightDict else {
                return false
            }
            return NSDictionary(dictionary: ld) == NSDictionary(dictionary: rd)
        }
    } else if type == .nativeArray || type == .foreignArray {
        
        let leftArray  = lhs.toArray()
        let rightArray = rhs.toArray()
        
        if leftArray == nil && rightArray == nil {
            return true
        } else {
            guard let la = leftArray, let ra = rightArray else {
                return false
            }
            return NSArray(array: la) == NSArray(array: ra)
        }
    } else {
        fatalError("\(#function): 'whatThe")
    }
}


// MARK: - Error types

enum PayloadDecodeError: Error {
    case unsupportedJSONRootObjectType
    case invalidTextEncodingError // data not UTF-8
    case expectedDataNotPresent
}


enum PayloadEncodeError: Error {
    case jsonConversionFailed
}


extension Payload {
    
    // DUBIOUS CODE
    // Moving this to this extension for now; but probably this is all destined for deletion:
    // 1. It isn't used (but I think it's used in Swagger branch)
    // 2. Swift 4 supports generic subscripts, with which we could make a nicer API than this
    
    // Like `somePayload[.key] except that it will attempt to coerce EXPERIMENTAL BRO
    
    
    public func decodeBool(_ key: PayloadKey) -> Bool? {
        return self[key] as? Bool
    }
    
    public func decodeString(_ key: PayloadKey) -> String? {
        return self[key] as? String
    }
    
    public func decodeStringArray(_ key: PayloadKey) -> [String]? {
        return self[key] as? [String]
    }
    
    public func decodeInt64(_ key: PayloadKey) -> Int64? {
        if let result = self[key] as? Int64 {
            return result
        } else if let result = self[key] as? NSNumber {
            return result.int64Value
        } else {
            return nil
        }
    }
    
    public func decodeInt(_ key: PayloadKey) -> Int64? {
        if let result = self[key] as? Int64 {
            return result
        } else if let result = self[key] as? NSNumber {
            return result.int64Value
        } else {
            return nil
        }
    }
    
    public func decodeDouble(_ key: PayloadKey) -> Double? {
        
        if let result = self[key] as? NSNumber {
            return result.doubleValue
        } else {
            return nil
        }
        
    }
    
    public func decodeArray(_ key: PayloadKey) -> [Any]? {
        return self[key] as? [Any]
    }
    
    public func decodeDictionary(_ key: PayloadKey) -> [String:Any]? {
        return self[key] as? [String: Any]
    }
    
    
    //    public func decodeSessionStatus(_ key: PayloadKey) -> SessionStatus? {
    //        
    //        if let dict = self[key] as? [String:Any], let childPayload = Payload.fromDictionary(dict) {
    //            return SessionStatus.from(childPayload)
    //        } else if let nativeObject = self[key] as? SessionStatus {
    //            return nativeObject
    //        } else {
    //            return nil
    //        }
    //    }

}
