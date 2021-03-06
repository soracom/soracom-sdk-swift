//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class DataEntry: Codable, Equatable {

    public var content: String?

    public var contentType: String?

    public var time: Int?

    public init(content: String? = nil, contentType: String? = nil, time: Int? = nil) {
        self.content = content
        self.contentType = contentType
        self.time = time
    }

    private enum CodingKeys: String, CodingKey {
        case content
        case contentType
        case time
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        content = try container.decodeIfPresent(.content)
        contentType = try container.decodeIfPresent(.contentType)
        time = try container.decodeIfPresent(.time)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(contentType, forKey: .contentType)
        try container.encodeIfPresent(time, forKey: .time)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? DataEntry else { return false }
      guard self.content == object.content else { return false }
      guard self.contentType == object.contentType else { return false }
      guard self.time == object.time else { return false }
      return true
    }

    public static func == (lhs: DataEntry, rhs: DataEntry) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
