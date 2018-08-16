// Metrics.swift Created by mason on 2018-07-27. 

import Foundation

/**
 Metrics is a simple class for keeping track of various things in an inspectable way during development.
 */
open class Metrics {
    
    static let sharedInstance = Metrics()
    
    var records: [Record] = []
    
    
    public enum RecordType {
        
        case wtf
        case decodeFailure
        case encodeFailure
    }
    
    
    public struct Record {
        
        let type: RecordType
        
        let description: String
        
        let error: Error?
        
        let data: Data?
        
        let date: Date = Date()
        
        init(type: RecordType, description: Any? = nil, error: Error? = nil, data: Data? = nil) {
            self.type = type
            self.description = String(describing: description)
            self.error = error
            self.data = data
        }
    }
    
    
    public static func record(type: RecordType, description: Any? = nil, error: Error? = nil, data: Data? = nil) {
        Metrics.sharedInstance.record(type: type, description: description, error: error, data: data)
    }
    
    
    open func record(type: RecordType, description: Any? = nil, error: Error? = nil, data: Data? = nil) {
        
        records.append(Record(type: type, description: description, error: error, data: data))
    }
    
}
