//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class LagoonUserPasswordUpdatingRequest: Codable, Equatable {

    public var newPassword: String?

    public var oldPassword: String?

    public var userEmail: String?

    public init(newPassword: String? = nil, oldPassword: String? = nil, userEmail: String? = nil) {
        self.newPassword = newPassword
        self.oldPassword = oldPassword
        self.userEmail = userEmail
    }

    private enum CodingKeys: String, CodingKey {
        case newPassword
        case oldPassword
        case userEmail
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        newPassword = try container.decodeIfPresent(.newPassword)
        oldPassword = try container.decodeIfPresent(.oldPassword)
        userEmail = try container.decodeIfPresent(.userEmail)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(newPassword, forKey: .newPassword)
        try container.encodeIfPresent(oldPassword, forKey: .oldPassword)
        try container.encodeIfPresent(userEmail, forKey: .userEmail)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? LagoonUserPasswordUpdatingRequest else { return false }
      guard self.newPassword == object.newPassword else { return false }
      guard self.oldPassword == object.oldPassword else { return false }
      guard self.userEmail == object.userEmail else { return false }
      return true
    }

    public static func == (lhs: LagoonUserPasswordUpdatingRequest, rhs: LagoonUserPasswordUpdatingRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
