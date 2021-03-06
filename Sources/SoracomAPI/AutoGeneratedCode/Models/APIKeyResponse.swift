//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class APIKeyResponse: Codable, Equatable {

    public var apiKey: String?

    public init(apiKey: String? = nil) {
        self.apiKey = apiKey
    }

    private enum CodingKeys: String, CodingKey {
        case apiKey
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        apiKey = try container.decodeIfPresent(.apiKey)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(apiKey, forKey: .apiKey)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? APIKeyResponse else { return false }
      guard self.apiKey == object.apiKey else { return false }
      return true
    }

    public static func == (lhs: APIKeyResponse, rhs: APIKeyResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
