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

final class Payload: DictionaryLiteralConvertible, PayloadConvertible, Equatable {
    
    /// Init a Payload from data (which should be UTF-8 encoded JSON).
    
    init?(data: NSData?) throws {
        
        guard let data = data else {
            return nil // not an error — nil data means payload should also be nil (means nonexistent)
        }
        
        guard String(data: data, encoding: NSUTF8StringEncoding) != nil else {
            throw PayloadDecodeError.InvalidTextEncodingError
        }
        
        guard data != NSData() else {
            // Mason 2016-07-01: is this an appropriate way to handle this? What are the rules governing whether we get nil or and empty NSData instance?
            rootObjectType = .ForeignDictionary
            return
        }
        
        let obj = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        
        if let dict = obj as? [String:AnyObject] {
            
            rootObjectType = .ForeignDictionary
            self.parseRootObject(dict)
            
        } else if let array = obj as? [AnyObject] {
            
            rootObjectType = .ForeignArray
            self.parseRootObject(array)
            
        } else {
            
            throw PayloadDecodeError.UnsupportedJSONRootObjectType
        }

    }
    
    /// Init a Payload via a dictionary literal (common when creating payloads to send).
    
    init(dictionaryLiteral elements: (PayloadKey, AnyObject)...) {
        
        rootObjectType = .NativeDictionary
        
        for (k,v) in elements {
            self[k] = v
        }
    }


    init(list: [Any]) {
        
        rootObjectType = .NativeArray
        
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
        
        rootObjectType = .NativeArray
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
    
    func parseRootObject(dictionary: [String:AnyObject]) {
        
        for (k,v) in dictionary {
            
            if let key = PayloadKey(rawValue: k) {
                
                self[key] = v
                
            } else {
                
                print("Payload.fromDictionary(): warning: \(k) is not a known PayloadKey value; ignoring")
                // FIXME: consider how this should really be handled.
            }
        }
    }
    
    
    func parseRootObject(foreignArray: [AnyObject]) {
        
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
    
    func coerceValueToBasicType(oldValue: Any) -> AnyObject? {
        
        if let newValue = oldValue as? PayloadConvertible {
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
        
        guard rootObjectType == .ForeignDictionary || rootObjectType == .NativeDictionary else {
            return nil
        }
        
        var result: [String:AnyObject] = [:]

        for (oldKey, oldValue) in rootDictionary {
            
            let newKey   = oldKey.stringValue
            let newValue = coerceValueToBasicType(oldValue)
            
            if newValue != nil {
                
                result[newKey] = newValue
            
            } else {
                
                print("FIXME: figure out to do when this happens: coerceValueToBasicType() returned nil")
            }
        }
        
        return result
    }
    
    
    /// Returns a 'basic' array representation of the receiver, suitable for encoding as JSON, or `nil` if the receiver's `rootObjectType` is not an array type. (A 'basic' value here means something NSJSONSerialization can handle.) This process converts objects conforming to `PayloadConvertible` to dictionaries containing 'basic' keys and values, using `coerceValueToBasicType()`.

    func toArray() -> [AnyObject]? {
        
        guard rootObjectType == .ForeignArray || rootObjectType == .NativeArray else {
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
    
    static func fromDictionary(src: [String: AnyObject]) -> Payload? {
        
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
        let result = String(data: toJSONData(), encoding: NSUTF8StringEncoding)
        return result
    }
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON (as UTF-8 string). The main purpose of this is for encoding a payload to send to the API server with a request, but it's also useful for tests.
    
    func toJSONData() -> NSData {
        
        do {
            var obj: AnyObject?
            
            switch rootObjectType {
                
                case .NativeDictionary:
                    obj = toDictionary()
                
                case .ForeignDictionary:
                    obj = toDictionary()
                
                case .NativeArray:
                    obj = toArray()
                
                case .ForeignArray:
                    obj = toArray()
            }
            
            guard let rootObj = obj else {
                throw PayloadEncodeError.JSONConversionFailed
            }
            
            let jsonData = try NSJSONSerialization.dataWithJSONObject(rootObj, options: .PrettyPrinted)
            return jsonData
            
        } catch {
            print("JSON encode error: \(error)")
            return NSData()
            
            // FIXME: still thinking about how to properly handle this kind of error. Seems like it should be a fatal error.
        }
    }
    
    
    /// Mark: Translating foreign data to native types
    
    /// If the receiver's root object is an array of JSON-encoded subscriber objects, this decodes the list, and returns an array of Subscriber structs. The list may be an empty array if no subscribers have been registered. Returns nil if the data seems bogus.
    
    func toSubscriberList() -> SubscriberList? {
        
        guard let tmp = toArray() else {
            return nil;
        }
        
        let a = tmp as NSArray
                
        var result: [Subscriber] = []
        
        for d in a {
            
            if let dict = d as? [String: AnyObject], subload = Payload.fromDictionary(dict)
            {
                result.append(Subscriber(subload))
            }
        }
        
        return result
    }
    
    
    /// Returns a list of Group objects, decoded from the receiver's root object.
    
    func toGroupList() -> GroupList? {
        
        guard let tmp = toArray() else {
            return nil;
        }
        
        let a = tmp as NSArray
        
        var result: [Group] = []
        
        for d in a {
            
            if let dict = d as? [String: AnyObject], subload = Payload.fromDictionary(dict)
            {
                result.append(Group(subload))
            }
        }
        
        return result
    }
    
    
    /// If the receiver's root object is a JSON object representing a subcriber, this decodes the object, and a Subscriber struct. Returns nil otherwise.
    
    func toSubscriber() -> Subscriber? {
        return Subscriber(self)
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
/// The 'ForeignXXX' variants only contain simple values, as result from decoding JSON data into native Swift objects. These types are used when decoding responses received from the API server. Because the data formats are not self-describing, Payload cannot deserialize this data into higher-level API objects without being told what type of object is wanted (e.g. by using a method like `toSubscriber()` or `toSubscriberList()`).
///
/// (**NOTE:** So far, array and dicttionary are the only two fundamental types I have encountered in the HTTP message body, but I have not yet examined the entire API. As far as the design of Payload goes, it should be able to support any valid JSON root object type (a topic on which various RFCs and implementations have [different opinions](http://stackoverflow.com/questions/3833299/can-an-array-be-top-level-json-text/3833312#3833312)...). However, I am not going to actually implement support for any other types until we neeed them. )

private enum PayloadRootObjectType {
    case NativeDictionary
    case ForeignDictionary
    case NativeArray
    case ForeignArray
}


// MARK: - Equatable conformance

/// Computes whether `lhs` and `rhs` are equivalent.
/// 
/// This used to just be implemented by converting the Payload instances to NSDictionary, and then asking NSDictionary if they are equal, but once we added support for non-dictionary payloads, it got more complicated `(T_T)`.

func ==(lhs: Payload, rhs: Payload) -> Bool
{
    guard lhs.rootObjectType == rhs.rootObjectType else {
        return false
    }
    
    let type = lhs.rootObjectType
    
    if type == .NativeDictionary ||  type == .ForeignDictionary {
        
        let leftDict  = lhs.toDictionary()
        let rightDict = rhs.toDictionary()
        
        if leftDict == nil && rightDict == nil {
            return true
        } else if leftDict == nil || rightDict == nil {
            return false
        } else {
            return (leftDict! as NSDictionary) == (rightDict! as NSDictionary)
        }
    } else if type == .NativeArray || type == .ForeignArray {
        
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


// MARK: - PayloadKey enum

/// The PayloadKey enum contains every valid key that is used in JSON objects sent to or received from the API server.
/// Its purpose is to make it a compile-time error if there is a typo in a key name.
///
/// The main use case is creating Payload objects:
///
///     let foo = [.amount: 1000, .description: "whatever"]

public enum PayloadKey: String {
    
    case amount
    case apiKey
    case apn
    case authKey
    case authKeyId
    case balance
    case beamStatsMap
    case billItemName
    case code
    case configuration
    case couponCode
    case createdAt
    case createDateTime
    case createdTime
    case credentials
    case credentialsId
    case cvc
    case dataTrafficStatsMap
    case description
    case dnsServers
    case downloadByteSizeTotal
    case downloadPacketSizeTotal
    case email
    case expiredAt
    case expireMonth
    case expireYear
    case expiryAction
    case expiryTime
    case expiryYearMonth
    case groupId
    case imei
    case imsi
    case inHttp
    case inMqtt
    case inTcp
    case inUdp
    case ipAddress
    case key
    case lastModifiedAt
    case lastModifiedTime
    case lastUsedDateTime
    case lastUpdatedAt
    case location
    case message
    case moduleType
    case msisdn
    case name
    case number
    case online
    case operatorId
    case outHttp
    case outHttps
    case outMqtt
    case outMqtts
    case outTcp
    case outTcps
    case outUdp
    case password
    case plan
    case registrationSecret
    case s1_fast                  // string key is "s1.fast"
    case s1_minimum               // string key is "s1.minimum"
    case s1_slow                  // string key is "s1.slow"
    case s1_standard              // string key is "s1.standard"
    case serialNumber
    case sessionStatus
    case speedClass
    case status
    case tags
    case tagName
    case tagValue
    case terminationEnabled
    case token
    case tokenTimeoutSeconds
    case type
    case ueIpAddress
    case unixtime
    case updateDateTime
    case uploadByteSizeTotal
    case uploadPacketSizeTotal
    case userName
    case value
    
    
    /// Convert the API key to the string representation used in the JSON-encoded request to the API server. **Usually** this is just the `rawValue` of the enum case, but some API keys have special characters that cannot be part of Swift enum case names, so those special cases are handled here.
    
    var stringValue: String {
        switch self {
        case .s1_fast:
            return "s1.fast"
        case .s1_slow:
            return "s1.slow"
        case .s1_minimum:
            return "s1.minimum"
        case .s1_standard:
            return "s1.standard"
        default:
            return self.rawValue
        }
    }

}


// MARK: - PayloadConvertible protocol

/// Types like Subscriber or AirStats need to implement PayloadConvertible, so that they can provide a Payload representation of themselves that can then be translated to a basic representation that the JSON encoder can deal with it.

protocol PayloadConvertible {
    func toPayload() -> Payload
}


// MARK: - Error types

enum PayloadDecodeError: ErrorType {
    case UnsupportedJSONRootObjectType
    case InvalidTextEncodingError // data not UTF-8
    case ExpectedDataNotPresent
}

enum PayloadEncodeError: ErrorType {
    case JSONConversionFailed
}
