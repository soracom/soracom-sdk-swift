// APIStructures.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// Description forthcoming.

public struct DataTrafficStats: PayloadConvertible {
    // rename to DataTrafficStats?
    
    static func from(_ payload: Payload?) -> DataTrafficStats? {
        fatalError("Mason 2017-07-14 TEMPORARY FIX FOR BUILD (reorganizing protocols) FIXME")
    }
    
    var uploadBytes: Int     = 0
    var uploadPackets: Int   = 0
    var downloadBytes: Int   = 0
    var downloadPackets: Int = 0
    
    // FIXME: ask Soracom guys what the relationship is between packets and bytes. This is just same data expressed in sane and insane forms?

    public func toPayload() -> Payload {
        return [
            .uploadByteSizeTotal     : uploadBytes,
            .uploadPacketSizeTotal   : uploadPackets,
            .downloadByteSizeTotal   : downloadBytes,
            .downloadPacketSizeTotal : downloadPackets
        ]
    }
}


/// Description forthcoming.

public struct AirStats: PayloadConvertible {
    
    static func from(_ payload: Payload?) -> AirStats? {
        fatalError("Mason 2017-07-14 TEMPORARY FIX FOR BUILD (reorganizing protocols) FIXME")
    }
    
    var traffic: [PayloadKey: DataTrafficStats]
    var unixtime: Int64
    // FIXME: is this just derived from unixtime, or....: var date: NSDate
    
    func toPayload() -> Payload {
        
        let result: Payload = [.unixtime: NSNumber(value: unixtime)]
        
        let dataTrafficStatsMap: Payload = [:]
        
        for (k, v) in traffic {
            dataTrafficStatsMap[k] = v.toPayload()
        }
        
        result[.dataTrafficStatsMap] = dataTrafficStatsMap
        return result
    }

}


/// Encapsulates the data for registering a payment method.

public struct PaymentMethodInfoWebPay {
    var cvc: String
    var expireMonth: Int
    var expireYear: Int
    var name: String
    var number: String
}



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

