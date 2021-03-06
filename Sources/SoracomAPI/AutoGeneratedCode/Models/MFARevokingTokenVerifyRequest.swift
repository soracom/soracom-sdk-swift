//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class MFARevokingTokenVerifyRequest: Codable, Equatable {

    public var backupCode: String?

    public var email: String?

    public var password: String?

    public var token: String?

    public init(backupCode: String? = nil, email: String? = nil, password: String? = nil, token: String? = nil) {
        self.backupCode = backupCode
        self.email = email
        self.password = password
        self.token = token
    }

    private enum CodingKeys: String, CodingKey {
        case backupCode
        case email
        case password
        case token
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        backupCode = try container.decodeIfPresent(.backupCode)
        email = try container.decodeIfPresent(.email)
        password = try container.decodeIfPresent(.password)
        token = try container.decodeIfPresent(.token)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(backupCode, forKey: .backupCode)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(token, forKey: .token)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? MFARevokingTokenVerifyRequest else { return false }
      guard self.backupCode == object.backupCode else { return false }
      guard self.email == object.email else { return false }
      guard self.password == object.password else { return false }
      guard self.token == object.token else { return false }
      return true
    }

    public static func == (lhs: MFARevokingTokenVerifyRequest, rhs: MFARevokingTokenVerifyRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
