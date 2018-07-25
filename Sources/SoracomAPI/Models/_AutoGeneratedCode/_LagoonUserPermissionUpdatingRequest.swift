//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _LagoonUserPermissionUpdatingRequest: Codable, Equatable {

    /** A role that represents the permission. */
    public enum Role: String, Codable {
        case viewer = "Viewer"
        case editor = "Editor"

        public static let cases: [Role] = [
          .viewer,
          .editor,
        ]
    }

    /** A role that represents the permission. */
    open var role: Role?

    public init(role: Role? = nil) {
        self.role = role
    }

    private enum CodingKeys: String, CodingKey {
        case role
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        role = try container.decodeIfPresent(.role)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(role, forKey: .role)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _LagoonUserPermissionUpdatingRequest else { return false }
      guard self.role == object.role else { return false }
      return true
    }

    public static func == (lhs: _LagoonUserPermissionUpdatingRequest, rhs: _LagoonUserPermissionUpdatingRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
