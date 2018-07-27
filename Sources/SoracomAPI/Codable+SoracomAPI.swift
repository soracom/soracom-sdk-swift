// Codable+SoracomAPI.swift Created by mason on 2017-07-14. 

import Foundation

/**
 Extends Encodable to be able to encode to a Payload object, via `toPayload()`. This lets us start to use the Codable protocols gradually, but not yet have to move away from Payload. 
*/
extension Encodable {
    
    /**
     Returns a Data instance containing a JSON-encoded representation of the receiver, or `nil` if encoding throws an error.
     */
    public func toData() -> Data? {

        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted]

        do {
            let jsonData = try e.encode(self)
            return jsonData
        } catch let err {
            Metrics.record(type: .encodeFailure, description: self, error: err)
            return nil
        }
    }

}


/**
 Extends Decodable to be able to decode single instances and lists, from either a Payload instance, or a Data instance (containing JSON data). This helps us start to use the Codable protocols gradually, while not yet having to move away from Payload. 
*/
extension Decodable {
    
    /**
     Returns an instance of `Self` if jsonData exists and contains valid JSON-encoded data, otherwise returns nil.
     */
    public static func from(_ jsonData: Data?) -> Self? {
        
        guard let d = jsonData else {
            return nil
        }
        return Self.from(d)
    }

    
    /**
     Returns an instance of `Self` if jsonData contains valid JSON-encoded data, otherwise returns nil.
     */
    public static func from(_ jsonData: Data) -> Self? {
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(Self.self, from: jsonData)
            return result
        } catch let err {
            Metrics.record(type: .decodeFailure, description: self, error: err, data: jsonData)
            return nil
        }
    }
    

    /**
     Returns a `[Self]` array if jsonData exists and contains valid JSON-encoded data, otherwise returns nil.
     */
    public static func listFrom(_ jsonData: Data) -> [Self]? {
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode([Self].self, from: jsonData)
            return result
        } catch let err {
            Metrics.record(type: .decodeFailure, description: "\(String(describing: self)).listFrom()", error: err, data: jsonData)
            return nil
        }
    }

}


//--------------------------------------------------------------
// OBSOLETE PAYLOAD-BASED FUNCTIONS BELOW WILL BE REMOVED:
//--------------------------------------------------------------


extension Encodable {
    
    
    
    /**
     OBSOLETE. Will be removed. Use `toData()` instead.
     */
    public func toPayload() -> Payload {
        
        let jsonData = self.toData()
        
        do {
            guard let result = try Payload(data: jsonData) else {
                return [:]
            }
            return result
        } catch {
            return [:]
        }
        // FIXME: this should probably throw, not return [:], but it is outside the scope
        // of what I am doing now, and anyway Payload may go away soon. (mason 2017-07-14)
    }
    
}

extension Decodable {
    
    /**
     OBSOLETE. Will be removed. Use `from(_: Data)` or `from(_: Data?)` instead.
     */
    public static func from(_ payload: Payload?) -> Self? {
        
        guard let payload = payload else {
            return nil
        }
        guard let jsonData = payload.toJSONData() else {
            return nil
        }
        return Self.from(jsonData)
    }
    
    
    /**
     OBSOLETE. Will be removed. Use `listFrom(_: Data)` or `listFrom(_: Data?)` instead.
     */
    public static func listFrom(_ payload: Payload?) -> [Self]? {
        
        guard let payload = payload else {
            return nil
        }
        guard let jsonData = payload.toJSONData() else {
            return nil
        }
        return listFrom(jsonData)
    }

}

