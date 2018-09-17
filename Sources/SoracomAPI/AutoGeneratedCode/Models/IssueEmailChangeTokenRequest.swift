//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class IssueEmailChangeTokenRequest: Codable, Equatable {

    public var email: String

    public init(email: String) {
        self.email = email
    }

    private enum CodingKeys: String, CodingKey {
        case email
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        email = try container.decode(.email)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(email, forKey: .email)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? IssueEmailChangeTokenRequest else { return false }
      guard self.email == object.email else { return false }
      return true
    }

    public static func == (lhs: IssueEmailChangeTokenRequest, rhs: IssueEmailChangeTokenRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
