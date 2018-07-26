//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _LagoonUserCreationRequest: Codable, Equatable {

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

    open var userEmail: String?

    open var userPassword: String?

    public init(role: Role? = nil, userEmail: String? = nil, userPassword: String? = nil) {
        self.role = role
        self.userEmail = userEmail
        self.userPassword = userPassword
    }

    private enum CodingKeys: String, CodingKey {
        case role
        case userEmail
        case userPassword
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        role = try container.decodeIfPresent(.role)
        userEmail = try container.decodeIfPresent(.userEmail)
        userPassword = try container.decodeIfPresent(.userPassword)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(userEmail, forKey: .userEmail)
        try container.encodeIfPresent(userPassword, forKey: .userPassword)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _LagoonUserCreationRequest else { return false }
      guard self.role == object.role else { return false }
      guard self.userEmail == object.userEmail else { return false }
      guard self.userPassword == object.userPassword else { return false }
      return true
    }

    public static func == (lhs: _LagoonUserCreationRequest, rhs: _LagoonUserCreationRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}