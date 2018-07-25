//
// SessionStatus.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class SessionStatus: Codable {

    public var dnsServers: [String]?
    public var imei: String?
    public var lastUpdatedAt: Int64?
    public var online: Bool?
    public var ueIpAddress: String?
    public var vpgId: String?
    public var gatewayPrivateIpAddress: String?
    public var gatewayPublicIpAddress: String?


    
    public init(dnsServers: [String]?, imei: String?, lastUpdatedAt: Int64?, online: Bool?, ueIpAddress: String?, vpgId: String?, gatewayPrivateIpAddress: String?, gatewayPublicIpAddress: String?) {
        self.dnsServers = dnsServers
        self.imei = imei
        self.lastUpdatedAt = lastUpdatedAt
        self.online = online
        self.ueIpAddress = ueIpAddress
        self.vpgId = vpgId
        self.gatewayPrivateIpAddress = gatewayPrivateIpAddress
        self.gatewayPublicIpAddress = gatewayPublicIpAddress
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(dnsServers, forKey: "dnsServers")
        try container.encodeIfPresent(imei, forKey: "imei")
        try container.encodeIfPresent(lastUpdatedAt, forKey: "lastUpdatedAt")
        try container.encodeIfPresent(online, forKey: "online")
        try container.encodeIfPresent(ueIpAddress, forKey: "ueIpAddress")
        try container.encodeIfPresent(vpgId, forKey: "vpgId")
        try container.encodeIfPresent(gatewayPrivateIpAddress, forKey: "gatewayPrivateIpAddress")
        try container.encodeIfPresent(gatewayPublicIpAddress, forKey: "gatewayPublicIpAddress")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        dnsServers = try container.decodeIfPresent([String].self, forKey: "dnsServers")
        imei = try container.decodeIfPresent(String.self, forKey: "imei")
        lastUpdatedAt = try container.decodeIfPresent(Int64.self, forKey: "lastUpdatedAt")
        online = try container.decodeIfPresent(Bool.self, forKey: "online")
        ueIpAddress = try container.decodeIfPresent(String.self, forKey: "ueIpAddress")
        vpgId = try container.decodeIfPresent(String.self, forKey: "vpgId")
        gatewayPrivateIpAddress = try container.decodeIfPresent(String.self, forKey: "gatewayPrivateIpAddress")
        gatewayPublicIpAddress = try container.decodeIfPresent(String.self, forKey: "gatewayPublicIpAddress")
    }
}

