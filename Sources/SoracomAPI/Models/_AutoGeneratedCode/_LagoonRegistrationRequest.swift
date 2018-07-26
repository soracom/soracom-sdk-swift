//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _LagoonRegistrationRequest: Codable, Equatable {

    public enum Plan: String, Codable {
        case maker = "maker"

        public static let cases: [Plan] = [
          .maker,
        ]
    }

    open var plan: Plan?

    /** This password is used by the initial user's login. */
    open var userPassword: String?

    public init(plan: Plan? = nil, userPassword: String? = nil) {
        self.plan = plan
        self.userPassword = userPassword
    }

    private enum CodingKeys: String, CodingKey {
        case plan
        case userPassword
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        plan = try container.decodeIfPresent(.plan)
        userPassword = try container.decodeIfPresent(.userPassword)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(plan, forKey: .plan)
        try container.encodeIfPresent(userPassword, forKey: .userPassword)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _LagoonRegistrationRequest else { return false }
      guard self.plan == object.plan else { return false }
      guard self.userPassword == object.userPassword else { return false }
      return true
    }

    public static func == (lhs: _LagoonRegistrationRequest, rhs: _LagoonRegistrationRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}