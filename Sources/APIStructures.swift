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


/// This structure contains the raw credential values pertaining to a foreign service like AWS.

public struct Credentials: PayloadConvertible {
    
    var accessKeyId: String     = ""
    var secretAccessKey: String? = nil
    
    func toPayload() -> Payload {

        let result: Payload = [
            .accessKeyId     : accessKeyId,
        ]
        
        if let k = secretAccessKey {
            result[.secretAccessKey] = k
        }
        
        return result
    }
}


/// This structure contains the values used to create or update a Credentials object.

public struct CredentialOptions: PayloadConvertible {
    
    var type: String
    var description: String
    var credentials: Credentials = Credentials()
    
    func toPayload() -> Payload {
        
        let result: Payload = [
            .type        : type,
            .description : description,
            .credentials : credentials.toPayload()
        ]
        return result
    }
}


/// This structure is the full credential object that is returned by the API server upon a successful `listCredentials()` or `createCredential()` request. 
///
/// **NOTE:** `Credential` objects returned by the API server contain a `Credential` structure, but that structure may not (always does not?) include the `secretAccessKey` value.

public struct Credential: PayloadConvertible {
    
    var createDateTime   : Int64?        = nil
    var credentials      : Credentials?  = nil
    var credentialsId    : String?       = nil
    var description      : String?       = nil
    var lastUsedDateTime : Int64?        = nil
    var type             : String?       = nil
    var updateDateTime   : Int64?        = nil
    
    init() {
        
    }
    
    
    init?(payload: Payload?) {
        
        guard let payload = payload else {
            return nil
        }
        
        if let created = payload[.createDateTime] as? NSNumber {
            createDateTime = created.longLongValue
        }
        
        if let credentialsDict = payload[.credentials] as? [String : AnyObject],
               subload         = Payload.fromDictionary(credentialsDict),
               accessKeyId     = subload[.accessKeyId] as? String
        {
            let secret = subload[.secretAccessKey] as? String // this normally won't be present
            credentials = Credentials(accessKeyId: accessKeyId, secretAccessKey: secret)
        }
        
        credentialsId = payload[.credentialsId] as? String
        description   = payload[.description]   as? String
        
        if let lastUsed = payload[.lastUsedDateTime] as? NSNumber {
            lastUsedDateTime = lastUsed.longLongValue
        }
        
        type = payload[.type] as? String
        
        if let updated = payload[.updateDateTime] as? NSNumber {
            updateDateTime = updated.longLongValue
        }
    }
    
    func toPayload() -> Payload {
        
        // FIXME: this serialization code is pathologically verbose and redundant...

        let result: Payload = [:]
        
        if let createDateTime = createDateTime {
            result[.createDateTime] = NSNumber(longLong: createDateTime)
        }
        
        if let credentials = credentials {
            result[.credentials] = credentials.toPayload()
        }
        
        if let credentialsId = credentialsId {
            result[.credentialsId] = credentialsId
        }
        
        if let description = description {
            result[.description] = description
        }
        
        if let lastUsedDateTime = lastUsedDateTime {
            result[.lastUsedDateTime] = NSNumber(longLong: lastUsedDateTime)
        }
        
        if let type = type {
            result[.type] = type
        }
        
        if let updateDateTime = updateDateTime {
            result[.updateDateTime] = NSNumber(longLong: updateDateTime)
        }
        
        return result
    }
}

public typealias CredentialList = [Credential]


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


/// Description forthcoming.

public struct Group {
    
    // Mason 2016-06-30: So far what I have seen, the use cases for this structure only involve receiving it,
    // and not sending it. When we modify groups, we do so by sending a subset of information (tags or config).
    
    // Mason 2016-06-30: There is some unresolved tension still between [String:String] and more structured
    // equivalents, like TagList and ConfigurationParameterList. As it stands now, Payload contains the more
    // structured data, but it's still being defined where the boundary is. For now I am implementing this
    // structure using just [String:String] because that seems like it would be substantially more convenient
    // for SDK end users...
    
    var configuration: [ConfigurationParametersNamespace: Dictionary<String,String>]?
    var createdTime: Int64?
    var groupId: String
    var lastModifiedTime: Int64?
    var operatorId: String?
    var tags: [String:String]?
    
    init(_ payload: Payload) {
        
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
            self.configuration = newConfig
        }
        
        if let n = payload[.createdTime] as? NSNumber {
            createdTime = n.longLongValue
        }
        groupId = payload[.groupId] as? String ?? "error"
        
        if let n = payload[.lastModifiedTime] as? NSNumber {
            lastModifiedTime = n.longLongValue
        }

        operatorId = payload[.operatorId] as? String
        tags       = payload[.tags]       as? [String:String]
    }
}

public typealias GroupList = [Group]


public struct Tag: PayloadConvertible {
    var tagName: String
    var tagValue: String

    func toPayload() -> Payload {
        return [
            .tagName  : tagName,
            .tagValue : tagValue,
        ]
    }
    
    
    init(tagName: String, tagValue: String) {
        self.tagName  = tagName
        self.tagValue = tagValue
    }
    
    
    init?(payload: Payload) {
        
        guard let name = payload[.tagName] as? String, value = payload[.tagValue] as? String else {
            return nil
        }
        tagName  = name
        tagValue = value
    }
}

public typealias TagList = [Tag]


public struct ConfigurationParameter: PayloadConvertible {
    public var key: String
    public var value: String
    
    func toPayload() -> Payload {
        return [
            .key   : key,
            .value : value,
        ]
    }
    
    init(key: String, value: String) {
        self.key   = key
        self.value = value
    }
    
    init?(payload: Payload) {
        
        guard let k = payload[.key] as? String, v = payload[.value] as? String else {
            return nil
        }
        key   = k
        value = v
    }
}

public typealias ConfigurationParameterList = [ConfigurationParameter]


public struct Subscriber: PayloadConvertible {
    
    var ipAddress: String?
    var speedClass: String?
    var imsi: String?
    
    init(_ payload: Payload) {
        ipAddress  = payload[.ipAddress]  as? String
        speedClass = payload[.speedClass] as? String
        imsi       = payload[.imsi]       as? String
    }
    
    func toPayload() -> Payload {
        return [
            .ipAddress  : ipAddress ?? "",
            .speedClass : speedClass ?? "",
            .imsi       : imsi ?? "",
        ]
        // FIXME: actually we should not set values to ""; they should simply not be present
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

public typealias SubscriberList = [Subscriber]


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


/// These namespaces are used to get/set configurations (lists of keys and values) pertaining to different Soracom services. (FIXME: Mason 2016-06-30: I don't really know how this works yet, just reading the API docs at this point.)

public enum ConfigurationParametersNamespace: String {
    case SoracomAir
    case SoracomBeam
}

