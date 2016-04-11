// APIStructures.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// This enum defines the HTTP methods actually used by this SDK.

enum HTTPMethod: String {
    case DELETE, GET, POST, PUT
}


/// FIXME: Mason 2016-03-23: What is this and what is it for? Generic credentials for cloud providers?

public struct Credential: PayloadConvertible {
    var createDateTime: Int        = 0
    var credentials: NSDictionary  = NSDictionary()
    var credentialsId : String     = "credentials ID"
    var description: String        = "description of credentials"
    var lastUsedDateTime: Int      = 0
    var type: String               = "aws-credentials"
    var updateDateTime: Int        = 0
    
    func toPayload() -> Payload {

        let result: Payload = [
            .createDateTime   : createDateTime,
            .credentials      : credentials,
            .credentialsId    : credentialsId,
            .description      : description,
            .lastUsedDateTime : lastUsedDateTime,
            .type             : type,
            .updateDateTime   : updateDateTime
        ]
        return result
    }

}


// A struct that contains a BeamStats struct, and a timestamp, for use with Request.insertBeamStats()

public struct BeamStatsInsertion: PayloadConvertible {
    var beamStats: BeamStats
    var unixtime: Int
    
    func toPayload() -> Payload {
        let result: Payload = [.unixtime: unixtime]
        result[.beamStatsMap] = beamStats.toPayload()
        return result
    }
}


// A struct that holds Beam statistics.

public struct BeamStats: PayloadConvertible {
    // FIXME: It would be nice if we could just use Swift.Int here, because Int is automagically bridged to NSNumber
    // and so we can just stick an Int into a Payload. However, we need to support 32-bit platforms, too, so I think
    // we need to change all the below to Int64, and then explicitly convert to NSNumber ourselves in toPayload()...
    var inHttp: Int
    var inMqtt: Int
    var inTcp: Int
    var inUdp: Int
    var outHttp: Int
    var outHttps: Int
    var outMqtt: Int
    var outMqtts: Int
    var outTcp: Int
    var outTcps: Int
    var outUdp: Int
    
    func toPayload() -> Payload {
        return [
            .inHttp   : inHttp,
            .inMqtt   : inMqtt,
            .inTcp    : inTcp,
            .inUdp    : inUdp,
            .outHttp  : outHttp,
            .outHttps : outHttps,
            .outMqtt  : outMqtt,
            .outMqtts : outMqtts,
            .outTcp   : outTcp,
            .outTcps  : outTcps,
            .outUdp   : outUdp
        ]
    }
}


/// Description forthcoming.

public struct AirStatsForSpeedClass: PayloadConvertible {
    var uploadBytes: Int     = 0
    var uploadPackets: Int   = 0
    var downloadBytes: Int   = 0
    var downloadPackets: Int = 0
    
    // FIXME: ask Soracom guys what the relationship is between packets and bytes. This is just same data expressed in sane and insane forms?

    func toPayload() -> Payload {
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
    var traffic: [PayloadKey: AirStatsForSpeedClass]
    var unixtime: Int64
    // FIXME: is this just derived from unixtime, or....: var date: NSDate
    
    func toPayload() -> Payload {
        
        let result: Payload = [.unixtime: NSNumber(longLong: unixtime)]
        
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
