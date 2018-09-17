//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class BeamCounts: Codable, Equatable {

    public var count: Int?

    public init(count: Int? = nil) {
        self.count = count
    }

    private enum CodingKeys: String, CodingKey {
        case count
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        count = try container.decodeIfPresent(.count)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(count, forKey: .count)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? BeamCounts else { return false }
      guard self.count == object.count else { return false }
      return true
    }

    public static func == (lhs: BeamCounts, rhs: BeamCounts) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
