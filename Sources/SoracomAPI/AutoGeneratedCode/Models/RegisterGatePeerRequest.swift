//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class RegisterGatePeerRequest: Codable, Equatable {

    public var outerIpAddress: String

    public var innerIpAddress: String?

    public init(outerIpAddress: String, innerIpAddress: String? = nil) {
        self.outerIpAddress = outerIpAddress
        self.innerIpAddress = innerIpAddress
    }

    private enum CodingKeys: String, CodingKey {
        case outerIpAddress
        case innerIpAddress
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        outerIpAddress = try container.decode(.outerIpAddress)
        innerIpAddress = try container.decodeIfPresent(.innerIpAddress)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(outerIpAddress, forKey: .outerIpAddress)
        try container.encodeIfPresent(innerIpAddress, forKey: .innerIpAddress)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? RegisterGatePeerRequest else { return false }
      guard self.outerIpAddress == object.outerIpAddress else { return false }
      guard self.innerIpAddress == object.innerIpAddress else { return false }
      return true
    }

    public static func == (lhs: RegisterGatePeerRequest, rhs: RegisterGatePeerRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
