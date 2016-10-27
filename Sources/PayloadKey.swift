// PayloadKey.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

/// The PayloadKey enum contains every valid key that is used in JSON objects sent to or received from the API server.
/// Its purpose is to make it a compile-time error if there is a typo in a key name.
///
/// The main use case is creating Payload objects:
///
///     let foo = [.amount: 1000, .description: "whatever"]

public enum PayloadKey: String {

    case accessKey
    case accessKeyId
    case actionConfigList
    case addressLine1
    case addressLine2
    case amount
    case apiKey
    case apn
    case authKey
    case authKeyId
    case authKeyList
    case balance
    case beamStatsMap
    case billItemName
    case billList
    case body
    case building
    case city
    case code
    case companyName
    case configuration
    case contentType
    case count
    case couponCode
    case couponList
    case createdAt
    case createDate
    case createDateTime
    case createdTime
    case credentials
    case credentialsId
    case currentPassword
    case cvc
    case dataTrafficStatsMap
    case date
    case department
    case description
    case destinationCidrBlock
    case deviceSubnetCidrRange
    case dns0
    case dns1
    case dnsServers
    case downloadByteSizeTotal
    case downloadPacketSizeTotal
    case email
    case endpoint
    case errorMessage
    case event
    case expiredAt
    case expireMonth
    case expireYear
    case expiryAction
    case expiryTime
    case expiryYearMonth
    case fields
    case from
    case fullName
    case functionName
    case gatewayPrivateIpAddress
    case gatewayPublicIpAddress
    case groupId
    case handlerId
    case hasPassword
    case headers
    case httpStatus
    case iccid
    case id
    case imei
    case imeiLock
    case imsi
    case inHttp
    case inMqtt
    case innerIpAddress
    case inTcp
    case inUdp
    case ipAddress
    case isOnline
    case key
    case lastEvaluatedTime
    case lastModifiedAt
    case lastModifiedTime
    case lastUpdatedAt
    case lastUsedDateTime
    case limitTotalTrafficMegaByte
    case location
    case maxQuantity
    case message
    case messageCode
    case moduleType
    case msisdn
    case name
    case newPassword
    case number
    case online
    case operatorId
    case orderDateTime
    case orderedSubscriberList
    case orderId
    case orderItemList
    case orderList
    case outerIpAddress
    case outHttp
    case outHttps
    case outMqtt
    case outMqtts
    case outTcp
    case outTcps
    case outUdp
    case ownedByCustomer
    case parameter1
    case parameter2
    case parameter3
    case parameter4
    case parameter5
    case password
    case paymentTransactionId
    case peerOwnerId
    case peerVpcId
    case permission
    case phoneNumber
    case plan
    case price
    case primaryServiceName
    case product
    case productAmount
    case productCode
    case productInfoURL
    case productList
    case productName
    case productType
    case properties
    case quantity
    case registrationSecret
    case roleId
    case roleList
    case rootOperatorId
    case ruleConfig
    case s1_fast                  // string key is "s1.fast"
    case s1_minimum               // string key is "s1.minimum"
    case s1_slow                  // string key is "s1.slow"
    case s1_standard              // string key is "s1.standard"
    case secretAccessKey
    case serialNumber
    case sessionStatus
    case shippingAddress
    case shippingAddressId
    case shippingArea
    case shippingAreaName
    case shippingCost
    case shippingCostList
    case shippingLabelNumber
    case size
    case speedClass
    case state
    case status
    case tagName
    case tags
    case tagValue
    case targetGroupId
    case targetImsi
    case targetOperatorId
    case targetTag
    case taxAmount
    case terminationEnabled
    case time
    case title
    case to
    case token
    case tokenTimeoutSeconds
    case totalAmount
    case transferDestinationOperatorEmail
    case transferDestinationOperatorId
    case transferImsi
    case transferredImsi
    case type
    case ueIpAddress
    case unixtime
    case updateDate
    case updateDateTime
    case uploadByteSizeTotal
    case uploadPacketSizeTotal
    case url
    case useInternetGateway
    case userName
    case value
    case virtualInterfaces
    case vpcPeeringConnections
    case vpgId
    case yearMonth
    case zipCode


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
