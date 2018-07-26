//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _ExpiryTime: Codable, Equatable {

    public enum ExpiryAction: String, Codable {
        case doNothing = "doNothing"
        case deleteSession = "deleteSession"
        case deactivate = "deactivate"
        case suspend = "suspend"
        case terminate = "terminate"

        public static let cases: [ExpiryAction] = [
          .doNothing,
          .deleteSession,
          .deactivate,
          .suspend,
          .terminate,
        ]
    }

    open var expiryTime: Int

    open var expiryAction: ExpiryAction?

    public init(expiryTime: Int, expiryAction: ExpiryAction? = nil) {
        self.expiryTime = expiryTime
        self.expiryAction = expiryAction
    }

    private enum CodingKeys: String, CodingKey {
        case expiryTime
        case expiryAction
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        expiryTime = try container.decode(.expiryTime)
        expiryAction = try container.decodeIfPresent(.expiryAction)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(expiryTime, forKey: .expiryTime)
        try container.encodeIfPresent(expiryAction, forKey: .expiryAction)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _ExpiryTime else { return false }
      guard self.expiryTime == object.expiryTime else { return false }
      guard self.expiryAction == object.expiryAction else { return false }
      return true
    }

    public static func == (lhs: _ExpiryTime, rhs: _ExpiryTime) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}