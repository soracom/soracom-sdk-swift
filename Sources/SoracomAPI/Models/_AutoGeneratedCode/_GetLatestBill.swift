//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _GetLatestBill: Codable, Equatable {

    /** 金額 */
    open var amount: Int?

    /** 利用額計算を実施した時間 */
    open var lastEvaluatedTime: String?

    public init(amount: Int? = nil, lastEvaluatedTime: String? = nil) {
        self.amount = amount
        self.lastEvaluatedTime = lastEvaluatedTime
    }

    private enum CodingKeys: String, CodingKey {
        case amount
        case lastEvaluatedTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        amount = try container.decodeIfPresent(.amount)
        lastEvaluatedTime = try container.decodeIfPresent(.lastEvaluatedTime)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(lastEvaluatedTime, forKey: .lastEvaluatedTime)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _GetLatestBill else { return false }
      guard self.amount == object.amount else { return false }
      guard self.lastEvaluatedTime == object.lastEvaluatedTime else { return false }
      return true
    }

    public static func == (lhs: _GetLatestBill, rhs: _GetLatestBill) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
