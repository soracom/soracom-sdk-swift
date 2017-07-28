// RequestPayload.swift Created by mason on 2017-07-28. 

import Foundation

/**
A mutable payload, used for sending API requests. WIP, name pending. Part of Swift 4 rewrite of Payload.  
*/
final public class RequestPayload: ResponsePayload, ExpressibleByDictionaryLiteral, Mutableペイロード, Encodable {
    
    
    public func encode(to encoder: Encoder) throws {
        
        if let _ = rootDictionary {
            var container = encoder.container(keyedBy: PayloadKey.self)
            for (key, value) in rootDictionary! {
                guard let realKey = PayloadKey(rawValue: key) else {
                    fatalError("WOPS")
                }
                try container.payloadEncode(value, forKey: realKey);
            }
            
        } else if let _ = rootArray {
            
        } else {
            
        }
        
    }
    
    public convenience init(dictionaryLiteral elements: (PayloadKey, Any)...) {
        self.init()
        rootDictionary = [:]
        
        for (k,v) in elements {
            self[k] = v
        }
    }
    
    public convenience init(array: [Any]) {
        self.init()
        rootArray = array
    }
    
    
    override subscript(key: PayloadKey) -> Any? {
        
        get {
            return rootDictionary?[key.rawValue]
        }
        set(newValue) {
            rootDictionary?[key.rawValue] = newValue
        }
    }
    
    override func toJSONData() -> Data? {
        
        let encoder = JSONEncoder()
        
        do {
            let result = try encoder.encode(self)
            return result
        } catch {
            return nil
        }
    }
    
}
