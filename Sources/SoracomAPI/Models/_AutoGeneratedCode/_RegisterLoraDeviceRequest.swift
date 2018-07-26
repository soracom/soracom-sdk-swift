//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _RegisterLoraDeviceRequest: Codable, Equatable {

    open var groupId: String?

    open var registrationSecret: String?

    open var tags: [String: String]?

    public init(groupId: String? = nil, registrationSecret: String? = nil, tags: [String: String]? = nil) {
        self.groupId = groupId
        self.registrationSecret = registrationSecret
        self.tags = tags
    }

    private enum CodingKeys: String, CodingKey {
        case groupId
        case registrationSecret
        case tags
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        groupId = try container.decodeIfPresent(.groupId)
        registrationSecret = try container.decodeIfPresent(.registrationSecret)
        tags = try container.decodeIfPresent(.tags)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(groupId, forKey: .groupId)
        try container.encodeIfPresent(registrationSecret, forKey: .registrationSecret)
        try container.encodeIfPresent(tags, forKey: .tags)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _RegisterLoraDeviceRequest else { return false }
      guard self.groupId == object.groupId else { return false }
      guard self.registrationSecret == object.registrationSecret else { return false }
      guard self.tags == object.tags else { return false }
      return true
    }

    public static func == (lhs: _RegisterLoraDeviceRequest, rhs: _RegisterLoraDeviceRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}