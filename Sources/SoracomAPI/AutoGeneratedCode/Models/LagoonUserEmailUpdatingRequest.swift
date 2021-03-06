//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class LagoonUserEmailUpdatingRequest: Codable, Equatable {

    public var userEmail: String?

    public init(userEmail: String? = nil) {
        self.userEmail = userEmail
    }

    private enum CodingKeys: String, CodingKey {
        case userEmail
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        userEmail = try container.decodeIfPresent(.userEmail)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(userEmail, forKey: .userEmail)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? LagoonUserEmailUpdatingRequest else { return false }
      guard self.userEmail == object.userEmail else { return false }
      return true
    }

    public static func == (lhs: LagoonUserEmailUpdatingRequest, rhs: LagoonUserEmailUpdatingRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
