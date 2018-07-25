//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _MonthlyBill: Codable, Equatable {

    /** 直近の課金ステータス */
    public enum PaymentStatus: String, Codable {
        case lessThanMinimumCharge = "lessThanMinimumCharge"
        case paying = "paying"
        case paid = "paid"
        case refunding = "refunding"
        case refunded = "refunded"
        case fail = "fail"

        public static let cases: [PaymentStatus] = [
          .lessThanMinimumCharge,
          .paying,
          .paid,
          .refunding,
          .refunded,
          .fail,
        ]
    }

    /** 金額 */
    open var amount: Int?

    /** 直近の課金ステータス */
    open var paymentStatus: PaymentStatus?

    /** 課金詳細取得用のID */
    open var paymentTransactionId: String?

    /** 年月 */
    open var yearMonth: String?

    public init(amount: Int? = nil, paymentStatus: PaymentStatus? = nil, paymentTransactionId: String? = nil, yearMonth: String? = nil) {
        self.amount = amount
        self.paymentStatus = paymentStatus
        self.paymentTransactionId = paymentTransactionId
        self.yearMonth = yearMonth
    }

    private enum CodingKeys: String, CodingKey {
        case amount
        case paymentStatus
        case paymentTransactionId
        case yearMonth
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        amount = try container.decodeIfPresent(.amount)
        paymentStatus = try container.decodeIfPresent(.paymentStatus)
        paymentTransactionId = try container.decodeIfPresent(.paymentTransactionId)
        yearMonth = try container.decodeIfPresent(.yearMonth)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(paymentStatus, forKey: .paymentStatus)
        try container.encodeIfPresent(paymentTransactionId, forKey: .paymentTransactionId)
        try container.encodeIfPresent(yearMonth, forKey: .yearMonth)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _MonthlyBill else { return false }
      guard self.amount == object.amount else { return false }
      guard self.paymentStatus == object.paymentStatus else { return false }
      guard self.paymentTransactionId == object.paymentTransactionId else { return false }
      guard self.yearMonth == object.yearMonth else { return false }
      return true
    }

    public static func == (lhs: _MonthlyBill, rhs: _MonthlyBill) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
