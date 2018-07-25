//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _ListRolesResponse: Codable, Equatable {

    open var createDateTime: Int?

    open var description: String?

    open var roleId: String?

    open var updateDateTime: Int?

    public init(createDateTime: Int? = nil, description: String? = nil, roleId: String? = nil, updateDateTime: Int? = nil) {
        self.createDateTime = createDateTime
        self.description = description
        self.roleId = roleId
        self.updateDateTime = updateDateTime
    }

    private enum CodingKeys: String, CodingKey {
        case createDateTime
        case description
        case roleId
        case updateDateTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        createDateTime = try container.decodeIfPresent(.createDateTime)
        description = try container.decodeIfPresent(.description)
        roleId = try container.decodeIfPresent(.roleId)
        updateDateTime = try container.decodeIfPresent(.updateDateTime)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(createDateTime, forKey: .createDateTime)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(roleId, forKey: .roleId)
        try container.encodeIfPresent(updateDateTime, forKey: .updateDateTime)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _ListRolesResponse else { return false }
      guard self.createDateTime == object.createDateTime else { return false }
      guard self.description == object.description else { return false }
      guard self.roleId == object.roleId else { return false }
      guard self.updateDateTime == object.updateDateTime else { return false }
      return true
    }

    public static func == (lhs: _ListRolesResponse, rhs: _ListRolesResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
