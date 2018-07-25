//
// FunnelConfiguration.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class FunnelConfiguration: Codable {

    public var enabled: Bool?
    public var credentialsId: String?
    public var destination: FunnelDestination?


    
    public init(enabled: Bool?, credentialsId: String?, destination: FunnelDestination?) {
        self.enabled = enabled
        self.credentialsId = credentialsId
        self.destination = destination
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(enabled, forKey: "enabled")
        try container.encodeIfPresent(credentialsId, forKey: "credentialsId")
        try container.encodeIfPresent(destination, forKey: "destination")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        enabled = try container.decodeIfPresent(Bool.self, forKey: "enabled")
        credentialsId = try container.decodeIfPresent(String.self, forKey: "credentialsId")
        destination = try container.decodeIfPresent(FunnelDestination.self, forKey: "destination")
    }
}

