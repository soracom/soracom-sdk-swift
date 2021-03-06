//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class SigfoxRegistrationRequest: Codable, Equatable {

    public var registrationSecret: String?

    public var tags: [String: String]?

    public init(registrationSecret: String? = nil, tags: [String: String]? = nil) {
        self.registrationSecret = registrationSecret
        self.tags = tags
    }

    private enum CodingKeys: String, CodingKey {
        case registrationSecret
        case tags
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        registrationSecret = try container.decodeIfPresent(.registrationSecret)
        tags = try container.decodeIfPresent(.tags)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(registrationSecret, forKey: .registrationSecret)
        try container.encodeIfPresent(tags, forKey: .tags)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? SigfoxRegistrationRequest else { return false }
      guard self.registrationSecret == object.registrationSecret else { return false }
      guard self.tags == object.tags else { return false }
      return true
    }

    public static func == (lhs: SigfoxRegistrationRequest, rhs: SigfoxRegistrationRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
