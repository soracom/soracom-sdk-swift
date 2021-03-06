//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class SetDeviceObjectModelScopeRequest: Codable, Equatable {

    public var scope: String?

    public init(scope: String? = nil) {
        self.scope = scope
    }

    private enum CodingKeys: String, CodingKey {
        case scope
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        scope = try container.decodeIfPresent(.scope)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(scope, forKey: .scope)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? SetDeviceObjectModelScopeRequest else { return false }
      guard self.scope == object.scope else { return false }
      return true
    }

    public static func == (lhs: SetDeviceObjectModelScopeRequest, rhs: SetDeviceObjectModelScopeRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
