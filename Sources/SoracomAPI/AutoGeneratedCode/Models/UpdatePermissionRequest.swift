//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class UpdatePermissionRequest: Codable, Equatable {

    public var operatorId: String?

    public init(operatorId: String? = nil) {
        self.operatorId = operatorId
    }

    private enum CodingKeys: String, CodingKey {
        case operatorId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        operatorId = try container.decodeIfPresent(.operatorId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(operatorId, forKey: .operatorId)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? UpdatePermissionRequest else { return false }
      guard self.operatorId == object.operatorId else { return false }
      return true
    }

    public static func == (lhs: UpdatePermissionRequest, rhs: UpdatePermissionRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
