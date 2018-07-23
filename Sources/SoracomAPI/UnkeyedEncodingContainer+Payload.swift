// UnkeyedEncodingContainer+Payload.swift Created by mason on 2017-07-30.

import Foundation

/**
 An extension to KeyedEncodingContainer specific to Payload, which implements:
 
 - recursive encoding of nested structures
 - encoding additional types that Payload needs to support (e.g. [PayloadKey: Any])
 - throwing when asked to encode types that Payload doesn't support
 - checking that all keys used in JSON output are valid (as defined by PayloadKey)
 
 FIXME: See KeyedEncodingContainer+Payload.swift for why that last point may need to be changed.
 */
extension UnkeyedEncodingContainer {
    
    /**
     This method is an entry point to the Payload's custom encoding, which validates both keys and value types, and does recursive encoding of nested structures.
     */
    mutating func payloadEncode(_ value: Any) throws {
        
        if let value = value as? String {
            
            try encode(value)
            
        } else if let value = value as? Int {
            
            try encode(value)
            
        } else if let value = value as? Int64 {
            
            try encode(value)
            
        } else if let value = value as? Bool {
            
            try encode(value)
            
        } else if let _ = value as? NSNull {
            
            try encodeNil()
            
        } else if let value = value as? [String:String] {
            
            try encode(value)
            
        } else if let value = value as? [String:Any] {
            
            try encode(value)
            
        } else if let value = value as? PayloadConvertible {
            
            if let dictValue = value.toPayload().toDictionary() {
                
                try encode(dictValue)
                
            } else if let arrayValue = value.toPayload().toArray() {
                
                try encode(arrayValue)
                
            } else {
                print("payloadEncode() is failing on unencodable Payload: \(String(describing: value)))")
                throw PayloadEncodeError.jsonConversionFailed
            }
            
        } else if let value = value as? Payload {
            
            if let dictValue = value.toDictionary() {
                
                try encode(dictValue)
                
            } else if let arrayValue = value.toArray() {
                
                try encode(arrayValue)
                
            } else {
                let bogusType = type(of: value)
                print("payloadEncode() is failing on unencodable PayloadConvertible: \(String(describing: value)) >> \(String(describing: bogusType))")
                throw PayloadEncodeError.invalidValueType(type: bogusType)
            }
            
        } else if let value = value as? [PayloadKey:Any] {
            
            try encode(value)
            
        } else if let value = value as? [Any] {
            
            try encode(value)
            
        } else {
            
            let bogusType = type(of: value)
            throw PayloadEncodeError.invalidValueType(type: bogusType)
        }
    }
    
    
    mutating func encode(_ value: [Any]) throws {
        
        var child = nestedUnkeyedContainer()
        
        for (v) in value {
            try child.payloadEncode(v)
        }
    }
    
    mutating func encode(_ value: [String: Any]) throws {
        
        
        var child = nestedContainer(keyedBy: PayloadKey.self) 
        //nestedContainer(keyedBy: PayloadKey.self, forKey: key)
        
        for (k, v) in value {
            guard let realKey = PayloadKey(rawValue: k) else {
                fatalError("WOPS")
            }
            try child.payloadEncode(v, forKey: realKey)                
        }
    } 
    
    mutating func encode(_ value: [PayloadKey: Any]) throws {
        
        
        var child = nestedContainer(keyedBy: PayloadKey.self) 
        //nestedContainer(keyedBy: PayloadKey.self, forKey: key)
        
        for (k, v) in value {
            try child.payloadEncode(v, forKey: k)                
        }
    } 
    
}

