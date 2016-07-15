// Group.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Description forthcoming.

public struct Group: PayloadConvertible {
    
    // Mason 2016-06-30: So far what I have seen, the use cases for this structure only involve receiving it,
    // and not sending it. When we modify groups, we do so by sending a subset of information (tags or config).
    
    // Mason 2016-06-30: There is some unresolved tension still between [String:String] and more structured
    // equivalents, like TagList and ConfigurationParameterList. As it stands now, Payload contains the more
    // structured data, but it's still being defined where the boundary is. For now I am implementing this
    // structure using just [String:String] because that seems like it would be substantially more convenient
    // for SDK end users...
    
    var configuration: [ConfigurationParametersNamespace: Dictionary<String,String>]? = nil
    var createdTime: Int64? = nil
    var groupId: String = ""
    var lastModifiedTime: Int64? = nil
    var operatorId: String? = nil
    var tags: [String:String]? = nil
    
    public static func from(payload: Payload?) -> Group? {
        
        guard let payload = payload else {
            return nil
        }
        
        var result = Group()
        
        if let config = payload[.configuration] as? [String: Dictionary<String,String>]  {
            
            var newConfig: [ConfigurationParametersNamespace: Dictionary<String,String>] = [:]
            
            // Data looks like this:
            // ["namespace": ["key": "value", "key": "value", ...], "namespace": ["key": "value", "key": "value", ...], ...]
            
            for (namespaceName, configParams) in config {
                
                guard let namespace = ConfigurationParametersNamespace(rawValue: namespaceName) else {
                    print("WARNING: skipping unknown group configuration namespace: \(namespaceName)")
                    continue
                }
                newConfig[namespace] = configParams
            }
            result.configuration = newConfig
        }
        
        if let n = payload[.createdTime] as? NSNumber {
            result.createdTime = n.longLongValue
        }
        result.groupId = payload[.groupId] as? String ?? "error"
        
        if let n = payload[.lastModifiedTime] as? NSNumber {
            result.lastModifiedTime = n.longLongValue
        }
        
        result.operatorId = payload[.operatorId] as? String
        result.tags       = payload[.tags]       as? [String:String]
        
        return result
    }
    
    
    public func toPayload() -> Payload {
        fatalError("unsupported: \(self) \(#function)") // FIXME: this should be temporary...
    }
}

public typealias GroupList = [Group]
