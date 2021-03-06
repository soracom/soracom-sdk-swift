//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class AuthKeyResponse: Codable, Equatable {

    public var authKeyId: String?

    public var createDateTime: Int?

    public var lastUsedDateTime: Int?

    public init(authKeyId: String? = nil, createDateTime: Int? = nil, lastUsedDateTime: Int? = nil) {
        self.authKeyId = authKeyId
        self.createDateTime = createDateTime
        self.lastUsedDateTime = lastUsedDateTime
    }

    private enum CodingKeys: String, CodingKey {
        case authKeyId
        case createDateTime
        case lastUsedDateTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        authKeyId = try container.decodeIfPresent(.authKeyId)
        createDateTime = try container.decodeIfPresent(.createDateTime)
        lastUsedDateTime = try container.decodeIfPresent(.lastUsedDateTime)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(authKeyId, forKey: .authKeyId)
        try container.encodeIfPresent(createDateTime, forKey: .createDateTime)
        try container.encodeIfPresent(lastUsedDateTime, forKey: .lastUsedDateTime)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? AuthKeyResponse else { return false }
      guard self.authKeyId == object.authKeyId else { return false }
      guard self.createDateTime == object.createDateTime else { return false }
      guard self.lastUsedDateTime == object.lastUsedDateTime else { return false }
      return true
    }

    public static func == (lhs: AuthKeyResponse, rhs: AuthKeyResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
