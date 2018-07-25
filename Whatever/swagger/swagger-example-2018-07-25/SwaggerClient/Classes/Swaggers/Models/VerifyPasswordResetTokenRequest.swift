//
// VerifyPasswordResetTokenRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class VerifyPasswordResetTokenRequest: Codable {

    public var password: String
    public var token: String


    
    public init(password: String, token: String) {
        self.password = password
        self.token = token
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(password, forKey: "password")
        try container.encode(token, forKey: "token")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        password = try container.decode(String.self, forKey: "password")
        token = try container.decode(String.self, forKey: "token")
    }
}

