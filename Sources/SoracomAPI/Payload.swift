// Payload.swift Created by mason on 2017-07-28. (A rewrite of the Payload.swift created by mason on 2016-03-26). Copyright © 2016-2017 Soracom, Inc. All rights reserved.

import Foundation

/**
Payload is used to represent the collection of values sent with an api request, or received in an API response. This is a complete rewite of Payload for Swift 4.
 */
public class Payload: Encodable, Equatable, ExpressibleByDictionaryLiteral {
    
    var rootDictionary: [String:Any]?
    var rootArray: [Any]?
    
    public var sourceData: Data?

    /// Default initializer does nothing.
    required public init() {        
    }
    
    
    public convenience init(array: [Any]) {
        self.init()
        rootArray = array
    }
    

    
    /// Init a Payload via a dictionary literal (common when creating payloads to send).
    
    public convenience required init(dictionaryLiteral elements: (PayloadKey, Any)...) {
        
        self.init()
        var dictionary: [String:Any] = [:]
        
        for (k,v) in elements {
            dictionary[k.rawValue] = v
        }
        rootDictionary = dictionary
    }
    
    
    public init?(data: Data?) throws {
        
        guard let data = data else {
            return nil // not an error — nil data means payload should also be nil (i.e., nonexistent)
        }
        
        guard String(data: data, encoding: String.Encoding.utf8) != nil else {
            throw PayloadDecodeError.invalidTextEncodingError
        }
        
        guard data != Data() else {
            rootDictionary = [:]
            return
        }
        
        let obj = try JSONSerialization.jsonObject(with: data, options: [])
        // Because this is a big unknown blob of JSON, we don't know what we
        // are getting. JSONSerialization does seem to work well for this use
        // case. Soracom API requests/responses are all either objects or arrays.
        
        sourceData = data
        
        if let dict = obj as? [String:Any] {
            
            rootDictionary = dict
            
        } else if let array = obj as? [Any] {
            
            rootArray = array
            
        } else {
            throw PayloadDecodeError.unsupportedJSONRootObjectType
        }
    }
    
    public subscript(key: PayloadKey) -> Any? {
        
        get {
            return rootDictionary?[key.rawValue]
        }
        set(newValue) {
            rootDictionary?[key.rawValue] = newValue
        }
    }
    
    
    // MARK: - Encoding
    
    /**
    We override `encode()` to call payloadEncode(), which is defined by our extensions to the encoder containers. This enforces our custom rules about how Payload can be encoded, does recursive encoding of nested structures, etc. 
    */
    public func encode(to encoder: Encoder) throws {
        
        if let d = rootDictionary {
            var container = encoder.container(keyedBy: PayloadKey.self)
            for (key, value) in d {
                guard let realKey = PayloadKey(rawValue: key) else {
                    fatalError("WOPS") // FIXME: replace this with more flexible PayloadCodingKey implementation, that allows dynamic keys based on arbitrary strings
                }
                try container.payloadEncode(value, forKey: realKey);
            }
            
        } else if let a = rootArray {
            var container = encoder.unkeyedContainer()
            for value in a {
                try container.payloadEncode(value);
            }
        } else {
            throw PayloadEncodeError.jsonConversionFailed
        }
        
    }

    
    public func toJSON() -> String? {
        
        guard let d = toJSONData() else {
            return nil
        }
        let result = d.utf8String
        return result
    }
    
    
    public func toJSONData() -> Data? {
        
        let encoder = JSONEncoder()
        
        do {
            let result = try encoder.encode(self)
            return result
        } catch {
            return nil
        }
    }
    
}

// MARK: - Equatable conformance

/// Computes whether `lhs` and `rhs` are equivalent.
/// 
/// This used to just be implemented by converting the Payload instances to NSDictionary, and then asking NSDictionary if they are equal, but once we added support for non-dictionary payloads, it got more complicated `(T_T)`.

public func ==(lhs: Payload, rhs: Payload) -> Bool
{
    guard let left = lhs.toJSONData(), let right = rhs.toJSONData() else {
        fatalError("JSON encode failure; this isn't yet handled")
    } 
    return JSONComparison.areEquivalent(left, right);
}


// MARK: - Error types

enum PayloadDecodeError: Error {
    case unsupportedJSONRootObjectType
    case invalidTextEncodingError // data not UTF-8
    case expectedDataNotPresent
}

enum PayloadEncodeError: Error {
    case invalidKey
    case invalidValueType(type: Any)
    case jsonConversionFailed
}


// MARK: - Dubious Code I

extension Payload {
    
    // DUBIOUS CODE
    // During rewriting Payload, I am putting all dubious old functionality in 
    // this extension. It should be reviewed, then either supported, or deleted.

    
    /// Init with a root object that is a native array.
    
    public convenience init(list: [Any]) {
        
        // FIXME: init(array:) replaces this
        
        self.init()
        self.rootArray = list
    }
    
    public convenience init(tagList: TagList) {
        
        // FIXME delete this in favor of more generic init 
        
        var a: [Any] = []
        for t in tagList {
            a.append(t)
        }
        self.init(list: a)
    }
    
    public convenience init(configurationParameterList: ConfigurationParameterList) {
        
        // FIXME delete this in favor of more generic init
        
        self.init(list: [])
        
        for cp in configurationParameterList {
            self.rootArray?.append(cp)
        }
        
        // Mason 2016-06-30: This is another way to solve the same compiler limitation as the "map {$0 as PayloadConvertible}" solution above.
        // FIXME 2017-07-14 (mason):
        // 1. above comment doesn't make sense; there's no "map {$0 as PayloadConvertible}" in this file
        // 2. what compiler limitation, and does it still exist
        // 3. init with FooObj belongs as an extension defined in FooObj.swift
    }
    
    public func toDictionary() -> [String:Any]? {
        
        // FIXME: get rid of this method! make tests that use it instead use JSON 
        
        guard let _ = self.rootDictionary, 
            let jsonData = self.toJSONData()
            else {
                return nil
        }
        do {
            let obj = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let result = obj as? [String:Any]
            return result
        } catch {
            return nil
        }
    }
    
    public static func fromDictionary(_ dictionary: [String:Any]) -> Payload? {

        // FIXME: get rid of this method! make tests that use it instead use JSON 

        do {
            let d = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return try Payload(data: d)
        } catch {
            return nil
        }
    }
    
    public func toArray() -> [Any]? {
        
        // FIXME: get rid of this method! make tests that use it instead use JSON
        
        guard let _ = self.rootArray, 
            let jsonData = self.toJSONData()
            else {
                return nil
        }
        do {
            let obj = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let result = obj as? [Any]
            return result
        } catch {
            return nil
        }
    }
    
    public static func fromArray(_ array: [Any]) -> Payload? {
        
        // FIXME: get rid of this method! make tests that use it instead use JSON
        
        do {
            let d = try JSONSerialization.data(withJSONObject: array, options: [])
            return try Payload(data: d)
        } catch {
            return nil
        }
        
    }
}


// MARK: - Dubious Code II

extension Payload {
    
    // DUBIOUS CODE II
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

// MARK: - Notes (to relocate or delete)

// LIST OF THINGS TO FIX AFTER REWRITE IS IN PLACE AND WORKING:
// - instead of SomeModelObject.listFrom(payload), make it SomeModelObject(payload:) 
//   (the original reason we didn't do that, to preserve automatic memberwise initializers, no longer applies)s





/**
 The `Payload` class represents the data payload (HTTP message body) contained by a Request or a Response. It has two purposes:
 
 - to hold a collection of values that will be sent to the API server with a request, or
 
 - to represent the collection of values received from the API server as part of a response.
 
 In most cases, client code won't need to construct payloads directly. For outgoing requests, the various convenience methods defined by `Request` create the payload under normal circumtances. And when a received from the API server, a payload is created automatically, and is available to you via the `Response` instance.
 
 Due to the original limitations of JSON in cross-platform Swift, `Payload` had to be able to do conversion between native Swift objects and the various objects defined by this SDK, and basic JSON-friendly representations of those objects.
 
 Now that Swift 4 is here, though, there's a much better JSON story. So Payload's role will likely be reduced. As of right now, though, it's still the intermediate data representation between API JSON data structures, and native objects in this SDK. 
*/


/*
     Thoughts on Payload
     2017-07-27
     
     I want to spend a couple minutes thinking out loud about Payload's reduced role in a Swift 4 / Codable world. 

     Payload is created, in the real world, in the following ways:

     1. Requests create them literally: 
     
         req.payload = [.foo: "bar"]
     
     This is useful; it's as easy (actually, easier) as just writing JSON directly, and it has the slight advantage that keys are checked. We don't want to have to pedantically create a Swift structure for every single possible bit of JSON that the API sends/receives. So Payload gives us this convenient representation of raw JSON, in that sense. (As of 2017-07-27 we do the former, but I think we should switch to the latter.)
     
     2. Requests create them from model object structures, like Credential:
     
         req.payload = Payload(configurationParameterList: parameters)
         // parameters is type [ConfigurationParameter]
     
     All model object structures conform to PayloadCovertible, and it seems like the new Codable JSON stuff in Swift 4 can satisfy all of our needs for encoding those.

     3. Responses create them from JSON data received from API server:
     
         result = try Payload(data: data)
     
     We have to decode whatever we get, and then inspect it and see if we can pull out the kinds of values we want, or an error, etc. This implies using JSONSerialization to decode the structure, which is always a JSON object (dictionary) or an array. 
     
     Unlike with encode, where JSONSerialization has lots of sharp corners and situations where it can't encode values (especially on Linux), I think it can *decode* any JSON response the API gives us, on macOS, Linux, and iOS. (I'll write some tests to prove that today, using some real API responses.)
     
     So the upshot of this thinking is: we still need Payload to standardize the interface for encoding/decoding objects, and to orchestrate our JSON serialization in the 3 scenarios above. But we don't need it to do as much, now that Swift 4 is (almost) here. 
     
     Specifically, I think we don't need:
     
     - dictionary/array intermediate representations; to/from JSON should be enough
     
     */
    
    
/// (**NOTE:** So far, array and object (dictionary) are the only two fundamental types I have encountered in the HTTP message body, but I have not yet examined the entire API. As far as the design of Payload goes, it should be able to support any valid JSON root object type (a topic on which various RFCs and implementations have [different opinions](http://stackoverflow.com/questions/3833299/can-an-array-be-top-level-json-text/3833312#3833312)...). However, I am not going to actually implement support for any other types until we neeed them. )
