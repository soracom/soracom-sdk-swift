// KeyedEncodingContainer+Payload.swift Created by mason on 2017-07-28. 

/**
 An extension to KeyedEncodingContainer specific to Payload, which implements:
 
 - recursive encoding of nested structures
 - encoding additional types that Payload needs to support (e.g. [PayloadKey: Any])
 - throwing when asked to encode types that Payload doesn't support
 - checking that all keys used in JSON output are valid (as defined by PayloadKey)
 
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
            
        } else if let value = value as? Bool {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? [String:Any] {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? [PayloadKey:Any] {
            
            try encode(value, forKey: key)
            
        } else if let value = value as? [Any] {
            
            try encode(value, forKey: key)
            
        } else {
            
            let bogusType = type(of: value)
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

extension UnkeyedEncodingContainer {
    
    /**
     This method is an entry point to the Payload's custom encoding, which validates both keys and value types, and does recursive encoding of nested structures.
     */
    mutating func payloadEncode(_ value: Any) throws {
        
        if let value = value as? String {
            
            try encode(value)
            
        } else if let value = value as? Int {
            
            try encode(value)
            
        } else if let value = value as? Bool {
            
            try encode(value)
            
        } else if let value = value as? [String:Any] {
            
            try encode(value)
            
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

}
