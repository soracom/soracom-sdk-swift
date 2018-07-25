//
// RoleResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RoleResponse: Codable {

    public var createDateTime: Int64?
    public var description: String?
    /** PermissionのJSON */
    public var permission: String?
    public var roleId: String?
    public var updateDateTime: Int64?


    
    public init(createDateTime: Int64?, description: String?, permission: String?, roleId: String?, updateDateTime: Int64?) {
        self.createDateTime = createDateTime
        self.description = description
        self.permission = permission
        self.roleId = roleId
        self.updateDateTime = updateDateTime
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(createDateTime, forKey: "createDateTime")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(permission, forKey: "permission")
        try container.encodeIfPresent(roleId, forKey: "roleId")
        try container.encodeIfPresent(updateDateTime, forKey: "updateDateTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        createDateTime = try container.decodeIfPresent(Int64.self, forKey: "createDateTime")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        permission = try container.decodeIfPresent(String.self, forKey: "permission")
        roleId = try container.decodeIfPresent(String.self, forKey: "roleId")
        updateDateTime = try container.decodeIfPresent(Int64.self, forKey: "updateDateTime")
    }
}

