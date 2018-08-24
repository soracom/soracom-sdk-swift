//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class ListPaymentStatementResponse: Codable, Equatable {

    /** 課金明細リスト */
    public var paymentStatementsList: [PaymentStatementResponse]?

    public init(paymentStatementsList: [PaymentStatementResponse]? = nil) {
        self.paymentStatementsList = paymentStatementsList
    }

    private enum CodingKeys: String, CodingKey {
        case paymentStatementsList
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        paymentStatementsList = try container.decodeArrayIfPresent(.paymentStatementsList)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(paymentStatementsList, forKey: .paymentStatementsList)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ListPaymentStatementResponse else { return false }
      guard self.paymentStatementsList == object.paymentStatementsList else { return false }
      return true
    }

    public static func == (lhs: ListPaymentStatementResponse, rhs: ListPaymentStatementResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}