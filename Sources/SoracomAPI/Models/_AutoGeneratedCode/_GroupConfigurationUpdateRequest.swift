//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _GroupConfigurationUpdateRequest: Codable, Equatable {

    open var key: String

    open var value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }

    private enum CodingKeys: String, CodingKey {
        case key
        case value
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        key = try container.decode(.key)
        value = try container.decode(.value)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(key, forKey: .key)
        try container.encode(value, forKey: .value)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _GroupConfigurationUpdateRequest else { return false }
      guard self.key == object.key else { return false }
      guard self.value == object.value else { return false }
      return true
    }

    public static func == (lhs: _GroupConfigurationUpdateRequest, rhs: _GroupConfigurationUpdateRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
