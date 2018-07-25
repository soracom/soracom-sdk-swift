//
// LagoonUserCreationResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class LagoonUserCreationResponse: Codable {

    /** Lagoon user ID assigned to the created user. */
    public var id: Int?


    
    public init(id: Int?) {
        self.id = id
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "id")
    }
}

