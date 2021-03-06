//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class AttachRoleRequest: Codable, Equatable {

    public var roleId: String?

    public init(roleId: String? = nil) {
        self.roleId = roleId
    }

    private enum CodingKeys: String, CodingKey {
        case roleId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        roleId = try container.decodeIfPresent(.roleId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(roleId, forKey: .roleId)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? AttachRoleRequest else { return false }
      guard self.roleId == object.roleId else { return false }
      return true
    }

    public static func == (lhs: AttachRoleRequest, rhs: AttachRoleRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
