//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class SetGroupRequest: Codable, Equatable {

    public var groupId: String?

    public var tags: Tag?

    public init(groupId: String? = nil, tags: Tag? = nil) {
        self.groupId = groupId
        self.tags = tags
    }

    private enum CodingKeys: String, CodingKey {
        case groupId
        case tags
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        groupId = try container.decodeIfPresent(.groupId)
        tags = try container.decodeIfPresent(.tags)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(groupId, forKey: .groupId)
        try container.encodeIfPresent(tags, forKey: .tags)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? SetGroupRequest else { return false }
      guard self.groupId == object.groupId else { return false }
      guard self.tags == object.tags else { return false }
      return true
    }

    public static func == (lhs: SetGroupRequest, rhs: SetGroupRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}