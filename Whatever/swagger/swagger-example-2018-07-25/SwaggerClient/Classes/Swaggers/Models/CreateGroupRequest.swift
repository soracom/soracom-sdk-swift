//
// CreateGroupRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class CreateGroupRequest: Codable {

    public var tags: Tag?


    
    public init(tags: Tag?) {
        self.tags = tags
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(tags, forKey: "tags")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        tags = try container.decodeIfPresent(Tag.self, forKey: "tags")
    }
}
