// PayloadKey.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

/// The PayloadKey enum contains every valid key that is used in JSON objects sent to or received from the API server.
/// Its purpose is to make it a compile-time error if there is a typo in a key name.
///
/// The main use case is creating Payload objects:
///
///     let foo = [.amount: 1000, .description: "whatever"]

public enum PayloadKey: String {
    
    case accessKeyId
    case amount
    case apiKey
    case apn
    case authKey
    case authKeyId
    case balance
    case beamStatsMap
    case billItemName
    case code
    case configuration
    case couponCode
    case createdAt
    case createDateTime
    case createdTime
    case credentials
    case credentialsId
    case cvc
    case dataTrafficStatsMap
    case description
    case dnsServers
    case downloadByteSizeTotal
    case downloadPacketSizeTotal
    case email
    case expiredAt
    case expireMonth
    case expireYear
    case expiryAction
    case expiryTime
    case expiryYearMonth
    case groupId
    case imei
    case imsi
    case inHttp
    case inMqtt
    case inTcp
    case inUdp
    case ipAddress
    case key
    case lastModifiedAt
    case lastModifiedTime
    case lastUsedDateTime
    case lastUpdatedAt
    case location
    case message
    case moduleType
    case msisdn
    case name
    case number
    case online
    case operatorId
    case outHttp
    case outHttps
    case outMqtt
    case outMqtts
    case outTcp
    case outTcps
    case outUdp
    case password
    case plan
    case registrationSecret
    case s1_fast                  // string key is "s1.fast"
    case s1_minimum               // string key is "s1.minimum"
    case s1_slow                  // string key is "s1.slow"
    case s1_standard              // string key is "s1.standard"
    case secretAccessKey
    case serialNumber
    case sessionStatus
    case speedClass
    case status
    case tags
    case tagName
    case tagValue
    case terminationEnabled
    case token
    case tokenTimeoutSeconds
    case type
    case ueIpAddress
    case unixtime
    case updateDateTime
    case uploadByteSizeTotal
    case uploadPacketSizeTotal
    case userName
    case value
    
    
    /// Convert the API key to the string representation used in the JSON-encoded request to the API server. **Usually** this is just the `rawValue` of the enum case, but some API keys have special characters that cannot be part of Swift enum case names, so those special cases are handled here.
    
    var stringValue: String {
        switch self {
        case .s1_fast:
            return "s1.fast"
        case .s1_slow:
            return "s1.slow"
        case .s1_minimum:
            return "s1.minimum"
        case .s1_standard:
            return "s1.standard"
        default:
            return self.rawValue
        }
    }
    
}
