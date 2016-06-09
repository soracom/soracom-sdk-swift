// Payload.swift Created by mason on 2016-03-26. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// The `Payload` class represents the data payload contained by a Request or a Response. (Behind the scenes, this is
/// typically a UTF-8 string that represents a JSON object.)
///
/// `Payload` behaves like a dictionary, but only allows keys of type PayloadKey. It has two purposes:
///
/// - to hold a collection of values that will be sent to the API server with a request, or
/// - to represent the collection of values received from the API server as part of a response.
///
/// It is a literal convertible, so you can initialize it like this:
///
///     let foo: Payload = [PayloadKey.amount: 666]
///     let bar: Payload = [.email: "foo@me.com"] 
///
/// (That second form is also fine, perhaps even preferred, but Xcode (7.3 as of this writing) isn't quite smart enough
/// to autocomplete the key name when you do it that way.)
///
/// **NOTE**: Payload doesn't enforce anything about its *values* however — at least not yet. Value should be one of
/// the following types:
///
/// - `Payload` (i.e., nested payload objects)
/// - `String` / `NSString`
/// - `NSNumber` containing a 64-bit integer, e.g.: `NSNumber(longLong: 5)` . `Swift.Int` isn't used because it is 32-bit on some supported platforms.
/// - `Dictionary` or `NSDictionary using string keys and containing only these types.
/// - `Array` or `NSArray` containing only these types.
///
/// Inadvertently using another type is an error, and may result in an exception at runtime (at JSON encode time).
///
/// **Future stuff:**
/// - Make immutable version, also (for responses coming back from server)
/// - Think a little more about what it means to validate keys, wrt to the possibility of this code executing in the
///   future. Enforcing valid keys when sending makes sense, but could there be a reason why future API server might
///   send somthing back that we don't understand? How should Payload behave in the face of receiving unknown keys?
/// - Do additional (runtime) checking of values (e.g. that each value is a legal type, and an appropriate kind for the key)
/// - Go crazy and implement compile time value-checking, too? I think there are only four legit value types: string, 
///   64-bit int, dictionary, array. So I think this could be done, with a few more literal convertible objects. But
///   since this doesn't even normally affect the end user (using the SDK, setting these values usually happens 
///   automatically) I doubt it would be worth it (except for being interesting to try).
/// - Decide if this whole thing was actually a good idea, or not.

final class Payload: DictionaryLiteralConvertible, PayloadConvertible, Equatable {
    
    /// Normal initializer is via a dictionary literal.
    
    init(dictionaryLiteral elements: (PayloadKey, AnyObject)...) {
        for (k,v) in elements {
            self[k] = v
        }
    }
    
    
    /// Compliance with this one is easy.
    
    func toPayload() -> Payload {
        return self
    }

    
    /// Convenience subscript accessor. 
    
    subscript(key: PayloadKey) -> AnyObject? {
        
        get {
            return dictionary[key]
        }
        
        set(newValue) {
            dictionary[key] = newValue
        }
    }

    
    /// Returns the receiver as a "plain" dictionary, which means:
    /// - keys are strings
    /// - values are basic types (NSJSONSerialization JSON-encodable types)
    
    func toDictionary() -> [String:AnyObject] {
        
        var result: [String:AnyObject] = [:]

        for (oldKey, oldValue) in dictionary {
            
            let newKey = oldKey.stringValue
            
            if let newValue = oldValue as? PayloadConvertible {
                // A match here means that the object is one of our custom objects, e.g. an AirStats struct, that
                // knows how to serialize itself in Payload form. So we let it do that, and then recursively
                // convert the nested Payload to a dictionary:
                
                result[newKey] = newValue.toPayload().toDictionary()
            }
            else if let newValue = oldValue as? String {
                result[newKey] = newValue
            }
            else if let newValue = oldValue as? NSNumber {
                result[newKey] = newValue
            }
            else if let newValue = oldValue as? NSDictionary {
                result[newKey] = newValue
            }
            else if let newValue = oldValue as? NSArray {
                result[newKey] = newValue
            }
            else if oldValue is NSNull {
                // do nothing in this case, I guess?
            }
            else {
                fatalError("work in progress bro (FIXME)")
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
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON (as UTF-8 string).
    
    func toJSONData() -> NSData {
        do {
            let dict = toDictionary()
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
            return jsonData
        } catch {
            print("JSON encode error: \(error)")
            return NSData()
            
            // FIXME: still thinking about how to properly handle this kind of error. Seems like it should be a fatal error.
        }
    }
    
    
    /// If the receiver's root object is an array of JSON-encoded subscriber objects, this decodes the list, and returns an array of Subscriber structs. The list may be an empty array if no subscribers have been registered. Returns nil if the data seems bogus.
    
    func toSubscriberList() -> [Subscriber]? {
        
        guard let a = self[.rootObject] as? NSArray else {
            return nil;
        }
        
        var result: [Subscriber] = []
        
        for d in a {
            
            if let dict = d as? [String: AnyObject], subload = Payload.fromDictionary(dict)
            {
                result.append(Subscriber(subload))
            }
        }
        
        return result
    }
    
    
    /// If the receiver's root object is a JSON object representing a subcriber, this decodes the object, and a Subscriber struct. Returns nil otherwise.
    
    func toSubscriber() -> Subscriber? {
        return Subscriber(self)
    }
    
    
    // MARK: - Private:
    
    /// The underlying private storage.
    
    private var dictionary: [PayloadKey:AnyObject] = Dictionary()

}


/// FIXME: PayloadError is a work in progress. May not be useful. At the least, on deserialization error, the error should capture the data so that the error handler can look at it. 

enum PayloadError: ErrorType {
    case WTF
    case InvalidKey(key: String)
}


// MARK: - Equatable conformance

/// Equatable is implemented by converting the Payload instances to NSDictionary, and then asking NSDictionary if they are equal.

func ==(lhs: Payload, rhs: Payload) -> Bool
{
    return (lhs.toDictionary() as NSDictionary) == (rhs.toDictionary() as NSDictionary)
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
    
    case rootObject
      // This rootObject is a special case. Sometimes the Soracom API returns a root object that is not a
      // dictionary, when it returns a JSON string the HTTP message body of a response. In such cases, the
      // resulting Payload instance will contain that root object as its single value, under this key.
      // 
      // Mason: 2016-06-08 this is an artifact of the Payload design. I am not yet sure whether I want to 
      // just live with it, or try to think of something better.
    
    case s1_fast                  // string key is "s1.fast"
    case s1_minimum               // string key is "s1.minimum"
    case s1_slow                  // string key is "s1.slow"
    case s1_standard              // string key is "s1.standard"
    case serialNumber
    case sessionStatus
    case speedClass
    case status
    case tags
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

/// A request value dictionary is of type Payload. However, that class doesn't know how to serialize struct types like AirStats. So types like that need to implement PayloadConvertible, so that they can provide a Payload representation of themselves that can then be transalted to [String:AnyObject] so that the JSON encoder can deal with it.

protocol PayloadConvertible {
    func toPayload() -> Payload
}


// MARK: - Error types
enum PayloadDecodeError: ErrorType {
    case NotYetImplemented
}
