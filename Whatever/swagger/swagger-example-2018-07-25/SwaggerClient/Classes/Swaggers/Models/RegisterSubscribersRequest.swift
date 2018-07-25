//
// RegisterSubscribersRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RegisterSubscribersRequest: Codable {

    public var registrationSecret: String
    public var groupId: String?
    public var tags: [TagUpdateRequest]?


    
    public init(registrationSecret: String, groupId: String?, tags: [TagUpdateRequest]?) {
        self.registrationSecret = registrationSecret
        self.groupId = groupId
        self.tags = tags
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(registrationSecret, forKey: "registrationSecret")
        try container.encodeIfPresent(groupId, forKey: "groupId")
        try container.encodeIfPresent(tags, forKey: "tags")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        registrationSecret = try container.decode(String.self, forKey: "registrationSecret")
        groupId = try container.decodeIfPresent(String.self, forKey: "groupId")
        tags = try container.decodeIfPresent([TagUpdateRequest].self, forKey: "tags")
    }
}

