//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class UserDetailResponse: Codable, Equatable {

    public var authKeyList: [AuthKeyResponse]?

    public var createDateTime: Int?

    public var description: String?

    public var hasPassword: Bool?

    public var permission: String?

    public var roleList: [ListRolesResponse]?

    public var updateDateTime: Int?

    public var userName: String?

    public init(authKeyList: [AuthKeyResponse]? = nil, createDateTime: Int? = nil, description: String? = nil, hasPassword: Bool? = nil, permission: String? = nil, roleList: [ListRolesResponse]? = nil, updateDateTime: Int? = nil, userName: String? = nil) {
        self.authKeyList = authKeyList
        self.createDateTime = createDateTime
        self.description = description
        self.hasPassword = hasPassword
        self.permission = permission
        self.roleList = roleList
        self.updateDateTime = updateDateTime
        self.userName = userName
    }

    private enum CodingKeys: String, CodingKey {
        case authKeyList
        case createDateTime
        case description
        case hasPassword
        case permission
        case roleList
        case updateDateTime
        case userName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        authKeyList = try container.decodeArrayIfPresent(.authKeyList)
        createDateTime = try container.decodeIfPresent(.createDateTime)
        description = try container.decodeIfPresent(.description)
        hasPassword = try container.decodeIfPresent(.hasPassword)
        permission = try container.decodeIfPresent(.permission)
        roleList = try container.decodeArrayIfPresent(.roleList)
        updateDateTime = try container.decodeIfPresent(.updateDateTime)
        userName = try container.decodeIfPresent(.userName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(authKeyList, forKey: .authKeyList)
        try container.encodeIfPresent(createDateTime, forKey: .createDateTime)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(hasPassword, forKey: .hasPassword)
        try container.encodeIfPresent(permission, forKey: .permission)
        try container.encodeIfPresent(roleList, forKey: .roleList)
        try container.encodeIfPresent(updateDateTime, forKey: .updateDateTime)
        try container.encodeIfPresent(userName, forKey: .userName)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? UserDetailResponse else { return false }
      guard self.authKeyList == object.authKeyList else { return false }
      guard self.createDateTime == object.createDateTime else { return false }
      guard self.description == object.description else { return false }
      guard self.hasPassword == object.hasPassword else { return false }
      guard self.permission == object.permission else { return false }
      guard self.roleList == object.roleList else { return false }
      guard self.updateDateTime == object.updateDateTime else { return false }
      guard self.userName == object.userName else { return false }
      return true
    }

    public static func == (lhs: UserDetailResponse, rhs: UserDetailResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
