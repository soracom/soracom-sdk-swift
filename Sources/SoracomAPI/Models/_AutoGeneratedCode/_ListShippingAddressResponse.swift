//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _ListShippingAddressResponse: Codable, Equatable {

    open var shippingAddresses: [GetShippingAddressResponse]?

    public init(shippingAddresses: [GetShippingAddressResponse]? = nil) {
        self.shippingAddresses = shippingAddresses
    }

    private enum CodingKeys: String, CodingKey {
        case shippingAddresses
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        shippingAddresses = try container.decodeArrayIfPresent(.shippingAddresses)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(shippingAddresses, forKey: .shippingAddresses)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _ListShippingAddressResponse else { return false }
      guard self.shippingAddresses == object.shippingAddresses else { return false }
      return true
    }

    public static func == (lhs: _ListShippingAddressResponse, rhs: _ListShippingAddressResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}