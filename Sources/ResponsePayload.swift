// ResponsePayload.swift Created by mason on 2017-07-28. 

import Foundation

/**
 A immutable payload object, used to represent the collection of values received in an API response. WIP, name pending. Part of Swift 4 rewrite of Payload.  
 */
public class ResponsePayload: ペイロード {
    
    var rootDictionary: [String:Any]?
    var rootArray: [Any]?
    var sourceData: Data?
    
    init() {
        
    }
    
    init?(data: Data?) throws {
        
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
    
    subscript(key: PayloadKey) -> Any? {
        
        get {
            return rootDictionary?[key.rawValue]
        }
    }
    
    func toJSON() -> String? {
        
        guard let d = toJSONData() else {
            return nil
        }
        let result = d.utf8String
        return result
    }
    
    
    func toJSONData() -> Data? {
        
        // Mason 2017-07-28: FIXME: for encoding, I think we don't need 
        // JSONSerialization, we can do it here the same way that RequestPayload does.
        // Look at this after we get this re-implementation of Payload farther along.
        
        do {        
            var jsonObject: Any?
            if (rootDictionary != nil) {
                jsonObject = rootDictionary
            } else {
                jsonObject = rootArray
            }
            if let jsonObject = jsonObject {
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                return jsonData
            } else {
                return nil
            }
        } catch {
            print("JSON encode error: \(error)")
            return nil 
        }
    }  
    
}

