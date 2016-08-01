// Payload.swift Created by mason on 2016-03-26. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// The `Payload` class represents the data payload contained by a Request or a Response.
///
/// `Payload` behaves like a dictionary, but only allows keys of type PayloadKey. It has two purposes:
///
/// - to hold a collection of values that will be sent to the API server with a request, or
/// - to represent the collection of values received from the API server as part of a response.
///
/// This means that `Payload` has to be able to do some conversion between native Swift objects and
/// various objects defined by this SDK, and basic JSON-friendly representations of those objects.
///
/// In most cases, client code won't need to construct payloads directly. For outgoing requests, the
/// various convenience methods defined by `Request` create the payload under normal circumtances. And
/// when a received from the API server, a payload is created automatically, and is available to you via
/// the `Response` instance.
///
/// Where client code tends to interact with `Payload` is requesting values from an incoming one.
///
/// If you do need to manually create one, `Payload` is a literal convertible, so you can initialize 
/// it like this:
///
///     let foo: Payload = [PayloadKey.amount: 666]
///     let bar: Payload = [.email: "foo@me.com"] 
///
/// (That second form is also fine, perhaps even preferred, but Xcode (7.3 as of this writing) isn't quite smart enough
/// to autocomplete the key name when you do it that way.)

public final class Payload: DictionaryLiteralConvertible, PayloadConvertible, Equatable {
    
    public static func from(_ payload: Payload?) -> Payload? {
        // FIXME: this is just a hack for conformance to PayloadConvertible. FIXME: It really shold be making a copy.
        return payload
    }

    
    /// Init a Payload from data (which should be UTF-8 encoded JSON).
    
    init?(data: Data?) throws {
        
        guard let data = data else {
            return nil // not an error — nil data means payload should also be nil (means nonexistent)
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
        
        if let dict = obj as? [String:AnyObject] {
            
            rootObjectType = .foreignDictionary
            self.parseRootObject(dict)
            
        } else if let array = obj as? [AnyObject] {
            
            rootObjectType = .foreignArray
            self.parseRootObject(array)
            
        } else {
            
            throw PayloadDecodeError.unsupportedJSONRootObjectType
        }
    }
    
    
    /// Init a Payload via a dictionary literal (common when creating payloads to send).
    
    public init(dictionaryLiteral elements: (PayloadKey, AnyObject)...) {
        
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
    }
    

    /// Compliance with this one is easy.
    
    func toPayload() -> Payload {
        return self
    }

    
    /// Convenience subscript accessor. 
    
    subscript(key: PayloadKey) -> AnyObject? {
        
        get {
            return rootDictionary[key]
        }
        
        set(newValue) {
            rootDictionary[key] = newValue
        }
    }

    
    // MARK: - Decoding
    
    func parseRootObject(_ dictionary: [String:AnyObject]) {
        
        for (k,v) in dictionary {
            
            if let key = PayloadKey(rawValue: k) {
                
                self[key] = v
                
            } else {
                
                print("Payload.fromDictionary(): warning: \(k) is not a known PayloadKey value; ignoring")
                // FIXME: consider how this should really be handled.
            }
        }
    }
    
    
    func parseRootObject(_ foreignArray: [AnyObject]) {
        
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
    
    func coerceValueToBasicType(_ oldValue: Any) -> AnyObject? {
        
        if let newValue = oldValue as? Subscriber {
            return newValue.toPayload().toDictionary()
        }
        else if let newValue = oldValue as? PayloadConvertible {
            // A match here means that the object is one of our custom objects, e.g. an AirStats struct, that
            // knows how to serialize itself in Payload form. So we let it do that, and then recursively
            // convert the nested Payload to a dictionary:
            
            return newValue.toPayload().toDictionary()
        }
        else if let newValue = oldValue as? String {
            return newValue
        }
        else if let newValue = oldValue as? NSNumber {
            return newValue
        }
        else if let newValue = oldValue as? NSDictionary {
            return newValue
        }
        else if let newValue = oldValue as? NSArray {
            return  newValue
        }
        else if oldValue is NSNull {
            // do nothing in this case, I guess?
        }
        else {
            fatalError("work in progress bro (FIXME)")
        }
        return nil
    }
    
    
    // Returns a 'basic' dictionary representation of the receiver, suitable for encoding as JSON, or `nil` if the receiver's `rootObjectType` is not a dictionary type. (A 'basic' value here means something NSJSONSerialization can handle.) This process converts objects conforming to `PayloadConvertible` to dictionaries containing 'basic' keys and values, using `coerceValueToBasicType()`.
    
    func toDictionary() -> [String:AnyObject]? {
        
        // FIXME: think about renaming this. toForeignDictionary()?
        
        guard rootObjectType == .foreignDictionary || rootObjectType == .nativeDictionary else {
            return nil
        }
        
        var result: [String:AnyObject] = [:]

        for (oldKey, oldValue) in rootDictionary {
            
            let newKey   = oldKey.stringValue
            let newValue = coerceValueToBasicType(oldValue)
            
            if newValue != nil {
                
                result[newKey] = newValue
            
            } else {
                
                print("FIXME: figure out to do when this happens: coerceValueToBasicType() returned nil for \(oldKey) / \(oldValue)")
            }
        }
        
        return result
    }
    
    
    /// Returns a 'basic' array representation of the receiver, suitable for encoding as JSON, or `nil` if the receiver's `rootObjectType` is not an array type. (A 'basic' value here means something NSJSONSerialization can handle.) This process converts objects conforming to `PayloadConvertible` to dictionaries containing 'basic' keys and values, using `coerceValueToBasicType()`.

    func toArray() -> [AnyObject]? {
        
        guard rootObjectType == .foreignArray || rootObjectType == .nativeArray else {
            return nil
        }
        
        var result: [AnyObject] = []
        
        for oldValue in rootArray {
            
            if let newValue = coerceValueToBasicType(oldValue) {
                
                result.append(newValue)
                
            } else {
                
                print("FIXME: figure out to do when this happens: \(#function): coerceValueToBasicType() returned nil")
            }
        }
        return result
    }
    
    
    /// Initialize and return a new Payload instance from `src`. 
    
    static func fromDictionary(_ src: [String: AnyObject]) -> Payload? {
        
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
        let result = String(data: toJSONData(), encoding: String.Encoding.utf8)
        return result
    }
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON (as UTF-8 string). The main purpose of this is for encoding a payload to send to the API server with a request, but it's also useful for tests.
    
    func toJSONData() -> Data {
        
        do {
            var obj: AnyObject?
            
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
            return Data()
            
            // FIXME: still thinking about how to properly handle this kind of error. Seems like it should be a fatal error.
        }
    }
    
    
    // MARK: - Private:
    
    /// The root object type is determined based on the data used to init the payload.
    
    private var rootObjectType: PayloadRootObjectType

    /// The underlying private storage (when `rootObjectType` is `.NativeDictionary` or `.ForeignDictionary`).
    
    private var rootDictionary: [PayloadKey:AnyObject] = [:]
    
    /// The underlying private storage (when `rootObjectType` is `.NativeArray` or `.ForeignArray`).
    
    private var rootArray: [Any] = []
    
}


/// The type of the root object (top-level object) in the JSON representation. This is typically Dictionary, but sometimes will be Array. 
///
/// The `NativeXXX` types may contain Swift objects and SDK objects, as long as those are types that Payload knows how to encode as JSON-safe values. These root object types are used for Payloads originating on the client side, to be sent with an API request. Payload knows how to convert these to JSON for sending over the wire.
///
/// The 'ForeignXXX' variants only contain simple values, as result from decoding JSON data into native Swift objects. These types are used when decoding responses received from the API server. Because the data formats are not self-describing, Payload cannot deserialize this data into higher-level API objects; instead that has to be delegated to the model object classes themselves. (Which means that you need to know what kind of object(s) you are trying to decode.)
///
/// (**NOTE:** So far, array and dicttionary are the only two fundamental types I have encountered in the HTTP message body, but I have not yet examined the entire API. As far as the design of Payload goes, it should be able to support any valid JSON root object type (a topic on which various RFCs and implementations have [different opinions](http://stackoverflow.com/questions/3833299/can-an-array-be-top-level-json-text/3833312#3833312)...). However, I am not going to actually implement support for any other types until we neeed them. )

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
        } else if leftDict == nil || rightDict == nil {
            return false
        } else {
            return (leftDict! as NSDictionary) == (rightDict! as NSDictionary)
        }
    } else if type == .nativeArray || type == .foreignArray {
        
        let leftArray  = lhs.toArray()
        let rightArray = rhs.toArray()
        
        if leftArray == nil && rightArray == nil {
            return true
        } else if leftArray == nil || rightArray == nil {
            return false
        } else {
            return (leftArray! as NSArray) == (rightArray! as NSArray)
        }
    } else {
        fatalError("\(#function): 'whatThe")
    }
}




// MARK: - Error types

enum PayloadDecodeError: ErrorProtocol {
    case unsupportedJSONRootObjectType
    case invalidTextEncodingError // data not UTF-8
    case expectedDataNotPresent
}

enum PayloadEncodeError: ErrorProtocol {
    case jsonConversionFailed
}
