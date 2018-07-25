//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _CreateOrUpdateRoleRequest: Codable, Equatable {

    /** PermissionのJSON */
    open var permission: String

    open var description: String?

    public init(permission: String, description: String? = nil) {
        self.permission = permission
        self.description = description
    }

    private enum CodingKeys: String, CodingKey {
        case permission
        case description
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        permission = try container.decode(.permission)
        description = try container.decodeIfPresent(.description)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(permission, forKey: .permission)
        try container.encodeIfPresent(description, forKey: .description)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _CreateOrUpdateRoleRequest else { return false }
      guard self.permission == object.permission else { return false }
      guard self.description == object.description else { return false }
      return true
    }

    public static func == (lhs: _CreateOrUpdateRoleRequest, rhs: _CreateOrUpdateRoleRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
