//
// ObjectInstance.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ObjectInstance: Codable {

    public var id: Int?
    public var resources: [String:ResourceInstance]?
    public var observed: Bool?


    
    public init(id: Int?, resources: [String:ResourceInstance]?, observed: Bool?) {
        self.id = id
        self.resources = resources
        self.observed = observed
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(resources, forKey: "resources")
        try container.encodeIfPresent(observed, forKey: "observed")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        id = try container.decodeIfPresent(Int.self, forKey: "id")
        resources = try container.decodeIfPresent([String:ResourceInstance].self, forKey: "resources")
        observed = try container.decodeIfPresent(Bool.self, forKey: "observed")
    }
}
