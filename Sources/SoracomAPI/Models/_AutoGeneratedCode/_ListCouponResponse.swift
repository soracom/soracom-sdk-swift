//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _ListCouponResponse: Codable, Equatable {

    /** クーポンリスト */
    open var couponList: [CouponResponse]?

    public init(couponList: [CouponResponse]? = nil) {
        self.couponList = couponList
    }

    private enum CodingKeys: String, CodingKey {
        case couponList
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        couponList = try container.decodeArrayIfPresent(.couponList)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(couponList, forKey: .couponList)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _ListCouponResponse else { return false }
      guard self.couponList == object.couponList else { return false }
      return true
    }

    public static func == (lhs: _ListCouponResponse, rhs: _ListCouponResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}