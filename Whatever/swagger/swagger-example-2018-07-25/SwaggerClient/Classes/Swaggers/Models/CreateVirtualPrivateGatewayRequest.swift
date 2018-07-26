//
// CreateVirtualPrivateGatewayRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CreateVirtualPrivateGatewayRequest: Codable {

    public enum PrimaryServiceName: String, Codable { 
        case canal = "Canal"
        case gate = "Gate"
    }
    public var primaryServiceName: PrimaryServiceName
    public var useInternetGateway: Bool?
    public var deviceSubnetCidrRange: String?


    
    public init(primaryServiceName: PrimaryServiceName, useInternetGateway: Bool?, deviceSubnetCidrRange: String?) {
        self.primaryServiceName = primaryServiceName
        self.useInternetGateway = useInternetGateway
        self.deviceSubnetCidrRange = deviceSubnetCidrRange
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(primaryServiceName, forKey: "primaryServiceName")
        try container.encodeIfPresent(useInternetGateway, forKey: "useInternetGateway")
        try container.encodeIfPresent(deviceSubnetCidrRange, forKey: "deviceSubnetCidrRange")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        primaryServiceName = try container.decode(PrimaryServiceName.self, forKey: "primaryServiceName")
        useInternetGateway = try container.decodeIfPresent(Bool.self, forKey: "useInternetGateway")
        deviceSubnetCidrRange = try container.decodeIfPresent(String.self, forKey: "deviceSubnetCidrRange")
    }
}
