// KeyedEncodingContainer+Payload.swift Created by mason on 2017-07-28.

import Foundation

/**
 An extension to KeyedEncodingContainer specific to Payload, which implements:
 
 - recursive encoding of nested structures
 - encoding additional types that Payload needs to support (e.g. [PayloadKey: Any])
 - throwing when asked to encode types that Payload doesn't support
 - checking that all keys used in JSON output are valid (as defined by PayloadKey)
 
 FIXME: I think we may need to change that last bullet point; instead we should probably use a PayloadCoadingKeys that can dynamically create a string key based on JSON data. Because although all tests currently pass with this design, I think eventually this code will also be used to encode user-defined data, also, in which case dynamic coding keys will be necessary. (Will need to be fixed in UnkeyedEncodingContainer extension as well.)
*/
extension KeyedEncodingContainer {
    
    /**
    This method is an entry point to the Payload's custom encoding, which validates both keys and value types, and does recursive encoding of nested structures.
    */
    mutating func payloadEncode(_ value: Any, forKey key: KeyedEncodingContainer.Key) throws {
        
        if let value = value as? String {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? Int {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? Int64 {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? Bool {
            
            try encode(value, forKey: key)
            
        } else if let _ = value as? NSNull {
            
            try encodeNil(forKey: key)
            
        } else if let value = value as? [String:String] {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? [String:Any] {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? Encodable {

            if let dictValue = value.toPayload().toDictionary() {
                
                try encode(dictValue, forKey: key)

            } else if let arrayValue = value.toPayload().toArray() {
                
                try encode(arrayValue, forKey: key)

            } else {
                let bogusType = type(of: value)
                print("payloadEncode() is failing on unencodable value: \(String(describing: value)) >> \(String(describing: bogusType))")
                throw PayloadEncodeError.invalidValueType(type: bogusType)
            }
            
        } else if let value = value as? Payload {
            
            if let dictValue = value.toDictionary() {
                
                try encode(dictValue, forKey: key)
                
            } else if let arrayValue = value.toArray() {
                
                try encode(arrayValue, forKey: key)
                
            } else {
                print("payloadEncode() is failing on unencodable Payload: \(String(describing: value)))")
                throw PayloadEncodeError.jsonConversionFailed
            }
            
        } else if let value = value as? [PayloadKey:Any] {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? [Any] {
            
            try encode(value, forKey: key)
            
        } else {
            
            let bogusType = type(of: value)
            print("payloadEncode() is failing on: \(String(describing: value)) >> \(String(describing: bogusType))")
            throw PayloadEncodeError.invalidValueType(type: bogusType)
        }
    }

    
    mutating func encode(_ value: [String: Any], forKey key: KeyedEncodingContainer.Key) throws {
        
        var child = nestedContainer(keyedBy: PayloadKey.self, forKey: key)
        
        for (k, v) in value {
            guard let realKey = PayloadKey(rawValue: k) else {
                fatalError("WOPS")
            }
            try child.payloadEncode(v, forKey: realKey)                
        }
    } 

    
    mutating func encode(_ value: [PayloadKey: Any], forKey key: KeyedEncodingContainer.Key) throws {
    
        var child = nestedContainer(keyedBy: PayloadKey.self, forKey: key)
        
        for (k, v) in value {
            try child.payloadEncode(v, forKey: k)                
        }
    }
    
    
    mutating func encode(_ value: [Any], forKey key: KeyedEncodingContainer.Key) throws {
        
        var child = nestedUnkeyedContainer(forKey: key)
        
        for (v) in value {
            try child.payloadEncode(v)
        }
    }
}
