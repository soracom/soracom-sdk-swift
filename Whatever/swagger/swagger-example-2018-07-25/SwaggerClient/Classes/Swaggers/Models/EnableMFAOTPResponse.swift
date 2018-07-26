//
// EnableMFAOTPResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class EnableMFAOTPResponse: Codable {

    public var totpUri: String?


    
    public init(totpUri: String?) {
        self.totpUri = totpUri
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(totpUri, forKey: "totpUri")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        totpUri = try container.decodeIfPresent(String.self, forKey: "totpUri")
    }
}
