//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class PaymentAmount: Codable, Equatable {

    public var taxAmount: Double?

    public var totalAmount: Double?

    public init(taxAmount: Double? = nil, totalAmount: Double? = nil) {
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
    }

    private enum CodingKeys: String, CodingKey {
        case taxAmount
        case totalAmount
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        taxAmount = try container.decodeIfPresent(.taxAmount)
        totalAmount = try container.decodeIfPresent(.totalAmount)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(taxAmount, forKey: .taxAmount)
        try container.encodeIfPresent(totalAmount, forKey: .totalAmount)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? PaymentAmount else { return false }
      guard self.taxAmount == object.taxAmount else { return false }
      guard self.totalAmount == object.totalAmount else { return false }
      return true
    }

    public static func == (lhs: PaymentAmount, rhs: PaymentAmount) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
