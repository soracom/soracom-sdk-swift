// Codable+SoracomAPI.swift Created by mason on 2017-07-14. 

import Foundation

/**
 Extends Encodable to be able to encode to a Payload object, via `toPayload()`. This lets us start to use the Codable protocols gradually, but not yet have to move away from Payload. 
*/
extension Encodable {
    
    func toPayload() -> Payload {
        
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
    
    func toData() -> Data? {

        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted]

        do {
            let jsonData = try e.encode(self)
            return jsonData
        } catch {
            return nil
        }
    }
}

extension Array where Element: Encodable & PayloadConvertible {

    func toPayload() -> Payload {
        
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
    
    func toData() -> Data? {
        
        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted]
        
        do {
            let jsonData = try e.encode(self)
            return jsonData
        } catch {
            return nil
        }
    }
}


/**
 Extends Decodable to be able to decode single instances and lists, from either a Payload instance, or a Data instance (containing JSON data). This helps us start to use the Codable protocols gradually, while not yet having to move away from Payload. 
*/
extension Decodable {
    
    static func from(_ payload: Payload?) -> Self? {
        
        guard let payload = payload else {
            return nil
        }
        guard let jsonData = payload.toJSONData() else {
            return nil
        }
        return Self.from(jsonData)
    }
    
    
    static func from(_ jsonData: Data) -> Self? {
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(Self.self, from: jsonData)
            return result
        } catch {
            print("Hmm, decode error: \(error)")
            return nil
        }
    }
    
    
    static func listFrom(_ payload: Payload?) -> [Self]? {
        
        guard let payload = payload else {
            return nil
        }
        guard let jsonData = payload.toJSONData() else {
            return nil
        }
        return listFrom(jsonData)
    }
    
    
    static func listFrom(_ jsonData: Data) -> [Self]? {
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode([Self].self, from: jsonData)
            return result
        } catch {
            print("Hmm, decode error: \(error)")
            return nil
        }
    }
}
