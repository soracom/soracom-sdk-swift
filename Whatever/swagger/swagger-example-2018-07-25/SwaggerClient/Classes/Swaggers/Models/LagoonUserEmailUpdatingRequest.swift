//
// LagoonUserEmailUpdatingRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class LagoonUserEmailUpdatingRequest: Codable {

    public var userEmail: String?


    
    public init(userEmail: String?) {
        self.userEmail = userEmail
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(userEmail, forKey: "userEmail")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        userEmail = try container.decodeIfPresent(String.self, forKey: "userEmail")
    }
}
