// Codable+SoracomAPI.swift Created by mason on 2017-07-14. 

import Foundation

/**
 Extends Encodable with `toData()` convenience method.
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
 Extends Decodable with convenience methods for decoding.
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
