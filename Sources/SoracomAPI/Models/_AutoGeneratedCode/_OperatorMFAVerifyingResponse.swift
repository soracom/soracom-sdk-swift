//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _OperatorMFAVerifyingResponse: Codable, Equatable {

    open var backupCodes: [String]?

    public init(backupCodes: [String]? = nil) {
        self.backupCodes = backupCodes
    }

    private enum CodingKeys: String, CodingKey {
        case backupCodes
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        backupCodes = try container.decodeArrayIfPresent(.backupCodes)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(backupCodes, forKey: .backupCodes)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _OperatorMFAVerifyingResponse else { return false }
      guard self.backupCodes == object.backupCodes else { return false }
      return true
    }

    public static func == (lhs: _OperatorMFAVerifyingResponse, rhs: _OperatorMFAVerifyingResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}