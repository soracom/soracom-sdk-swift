// APIStructures.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation




public struct Tag: PayloadConvertible {
    
    var tagName: String
    var tagValue: String

    func toPayload() -> Payload {
        return [
            .tagName  : tagName,
            .tagValue : tagValue,
        ]
    }
    
    
    public static func from(_ payload: Payload?) -> Tag? {
        
        guard let payload = payload, let name = payload[.tagName] as? String, let value = payload[.tagValue] as? String else {
            return nil
        }
        return Tag(tagName: name, tagValue: value)
    }
}

public typealias TagList = [Tag]


public struct ConfigurationParameter: PayloadConvertible, Codable {
    
    public var key: String
    public var value: String
}

public typealias ConfigurationParameterList = [ConfigurationParameter]



public enum TagValueMatchMode: String {
    // Mason 2016-06-08: FIXME: I am making some guesses about how this works and what the legal values are; confirm.
    case exact, prefix
}


/// These namespaces are used to get/set configurations (lists of keys and values) pertaining to different Soracom services.

public enum ConfigurationParametersNamespace: String {
    case SoracomAir
    case SoracomBeam
}


/// Defines all valid coverage types

public enum CoverageType: String {
    case japan  = "jp"
    case global = "g"
}

