//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class RoleResponse: Codable, Equatable {

    public var createDateTime: Int?

    public var description: String?

    /** PermissionのJSON */
    public var permission: String?

    public var roleId: String?

    public var updateDateTime: Int?

    public init(createDateTime: Int? = nil, description: String? = nil, permission: String? = nil, roleId: String? = nil, updateDateTime: Int? = nil) {
        self.createDateTime = createDateTime
        self.description = description
        self.permission = permission
        self.roleId = roleId
        self.updateDateTime = updateDateTime
    }

    private enum CodingKeys: String, CodingKey {
        case createDateTime
        case description
        case permission
        case roleId
        case updateDateTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        createDateTime = try container.decodeIfPresent(.createDateTime)
        description = try container.decodeIfPresent(.description)
        permission = try container.decodeIfPresent(.permission)
        roleId = try container.decodeIfPresent(.roleId)
        updateDateTime = try container.decodeIfPresent(.updateDateTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(createDateTime, forKey: .createDateTime)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(permission, forKey: .permission)
        try container.encodeIfPresent(roleId, forKey: .roleId)
        try container.encodeIfPresent(updateDateTime, forKey: .updateDateTime)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? RoleResponse else { return false }
      guard self.createDateTime == object.createDateTime else { return false }
      guard self.description == object.description else { return false }
      guard self.permission == object.permission else { return false }
      guard self.roleId == object.roleId else { return false }
      guard self.updateDateTime == object.updateDateTime else { return false }
      return true
    }

    public static func == (lhs: RoleResponse, rhs: RoleResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}