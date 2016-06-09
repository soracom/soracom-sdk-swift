// APIStructures.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// This enum defines the HTTP methods actually used by this SDK.

enum HTTPMethod: String {
    case DELETE, GET, POST, PUT
}


/// This is the object included in the response returned by the API auth() call. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/auth)

public struct AuthResponse {
    
    var apiKey: String?     = nil
    var operatorId: String? = nil
    var token: String?      = nil
    var userName: String?   = nil
    
    init?(_ payload: Payload?) {
        
        guard let payload = payload else {
            return nil
        }
        
        apiKey     = payload[.apiKey] as? String
        operatorId = payload[.operatorId] as? String
        token      = payload[.token] as? String
        userName   = payload[.userName] as? String
        
        guard apiKey != nil && token != nil else {
            return nil
        }
    }
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


public struct Subscriber {
    
    var ipAddress: String?
    var speedClass: String?
    var imsi: String?
    
    init(_ payload: Payload) {
        ipAddress  = payload[.ipAddress]  as? String
        speedClass = payload[.speedClass] as? String
        imsi       = payload[.imsi]       as? String
    }
    
    // FIXME: to be real we need to support all of this:
    
    //    {
    //    "ipAddress" : "10.48.37.87",
    //    "moduleType" : "nano",
    //    "status" : "ready",
    //    "plan" : 0,
    //    "imsi" : "001010929605213",
    //    "tags" : {
    //    
    //    },
    //    "speedClass" : "s1.fast",
    //    "expiryAction" : null,
    //    "sessionStatus" : {
    //    "ueIpAddress" : null,
    //    "online" : false,
    //    "lastUpdatedAt" : 1465374445531,
    //    "dnsServers" : null,
    //    "location" : null,
    //    "imei" : null
    //    },
    //    "createdAt" : 1465374445530,
    //    "lastModifiedTime" : 1465374445593,
    //    "operatorId" : "OP0060667224",
    //    "type" : "s1.fast",
    //    "apn" : "soracom-sandbox.io",
    //    "createdTime" : 1465374445530,
    //    "terminationEnabled" : false,
    //    "serialNumber" : "TS2142687158193",
    //    "groupId" : null,
    //    "expiryTime" : null,
    //    "lastModifiedAt" : 1465374445593,
    //    "msisdn" : "999949175086",
    //    "expiredAt" : null
    //    }
}


public enum SpeedClass: String {
    case s1_fast     = "s1.fast"
    case s1_minimum  = "s1.minimum"
    case s1_slow     = "s1.slow"
    case s1_standard = "s1.standard"
}


public enum SubscriberStatus: String {
    case active, inactive, ready, instock, shipped, suspended, terminated
}


public enum TagValueMatchMode: String {
    // Mason 2016-06-08: FIXME: I am making some guesses about how this works and what the legal values are; confirm.
    case exact, prefix
}

