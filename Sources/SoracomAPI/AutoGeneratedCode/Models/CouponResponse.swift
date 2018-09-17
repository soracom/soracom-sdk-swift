//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class CouponResponse: Codable, Equatable {

    /** クーポン額 */
    public var amount: Double?

    /** 残高 */
    public var balance: Double?

    /** 対象課金アイテム */
    public var billItemName: String?

    /** クーポンコード */
    public var couponCode: String?

    /** 有効期限 */
    public var expiryYearMonth: String?

    public init(amount: Double? = nil, balance: Double? = nil, billItemName: String? = nil, couponCode: String? = nil, expiryYearMonth: String? = nil) {
        self.amount = amount
        self.balance = balance
        self.billItemName = billItemName
        self.couponCode = couponCode
        self.expiryYearMonth = expiryYearMonth
    }

    private enum CodingKeys: String, CodingKey {
        case amount
        case balance
        case billItemName
        case couponCode
        case expiryYearMonth
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        amount = try container.decodeIfPresent(.amount)
        balance = try container.decodeIfPresent(.balance)
        billItemName = try container.decodeIfPresent(.billItemName)
        couponCode = try container.decodeIfPresent(.couponCode)
        expiryYearMonth = try container.decodeIfPresent(.expiryYearMonth)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(balance, forKey: .balance)
        try container.encodeIfPresent(billItemName, forKey: .billItemName)
        try container.encodeIfPresent(couponCode, forKey: .couponCode)
        try container.encodeIfPresent(expiryYearMonth, forKey: .expiryYearMonth)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? CouponResponse else { return false }
      guard self.amount == object.amount else { return false }
      guard self.balance == object.balance else { return false }
      guard self.billItemName == object.billItemName else { return false }
      guard self.couponCode == object.couponCode else { return false }
      guard self.expiryYearMonth == object.expiryYearMonth else { return false }
      return true
    }

    public static func == (lhs: CouponResponse, rhs: CouponResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
