//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class GetOrderResponse: Codable, Equatable {

    /** 発注ステータス */
    public enum OrderStatus: String, Codable {
        case ordering = "ordering"
        case ordered = "ordered"
        case kitting = "kitting"
        case shipped = "shipped"
        case received = "received"
        case cancelling = "cancelling"
        case cancelled = "cancelled"
        case failed = "failed"

        public static let cases: [OrderStatus] = [
          .ordering,
          .ordered,
          .kitting,
          .shipped,
          .received,
          .cancelling,
          .cancelled,
          .failed,
        ]
    }

    /** メールアドレス */
    public var email: String?

    /** 発注日時 */
    public var orderDateTime: String?

    /** 発注ID */
    public var orderId: String?

    /** 発注商品リスト */
    public var orderItemList: [EstimatedOrderItemModel]?

    /** 発注ステータス */
    public var orderStatus: OrderStatus?

    /** 発送先 */
    public var shippingAddress: ShippingAddressModel?

    /** 商品発送先ID */
    public var shippingAddressId: String?

    /** 配送料 */
    public var shippingCost: Double?

    /** 宅配便送り状番号 */
    public var shippingLabelNumber: String?

    /** 消費税 */
    public var taxAmount: Double?

    /** 合計金額 */
    public var totalAmount: Double?

    public init(email: String? = nil, orderDateTime: String? = nil, orderId: String? = nil, orderItemList: [EstimatedOrderItemModel]? = nil, orderStatus: OrderStatus? = nil, shippingAddress: ShippingAddressModel? = nil, shippingAddressId: String? = nil, shippingCost: Double? = nil, shippingLabelNumber: String? = nil, taxAmount: Double? = nil, totalAmount: Double? = nil) {
        self.email = email
        self.orderDateTime = orderDateTime
        self.orderId = orderId
        self.orderItemList = orderItemList
        self.orderStatus = orderStatus
        self.shippingAddress = shippingAddress
        self.shippingAddressId = shippingAddressId
        self.shippingCost = shippingCost
        self.shippingLabelNumber = shippingLabelNumber
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
    }

    private enum CodingKeys: String, CodingKey {
        case email
        case orderDateTime
        case orderId
        case orderItemList
        case orderStatus
        case shippingAddress
        case shippingAddressId
        case shippingCost
        case shippingLabelNumber
        case taxAmount
        case totalAmount
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        email = try container.decodeIfPresent(.email)
        orderDateTime = try container.decodeIfPresent(.orderDateTime)
        orderId = try container.decodeIfPresent(.orderId)
        orderItemList = try container.decodeArrayIfPresent(.orderItemList)
        orderStatus = try container.decodeIfPresent(.orderStatus)
        shippingAddress = try container.decodeIfPresent(.shippingAddress)
        shippingAddressId = try container.decodeIfPresent(.shippingAddressId)
        shippingCost = try container.decodeIfPresent(.shippingCost)
        shippingLabelNumber = try container.decodeIfPresent(.shippingLabelNumber)
        taxAmount = try container.decodeIfPresent(.taxAmount)
        totalAmount = try container.decodeIfPresent(.totalAmount)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(orderDateTime, forKey: .orderDateTime)
        try container.encodeIfPresent(orderId, forKey: .orderId)
        try container.encodeIfPresent(orderItemList, forKey: .orderItemList)
        try container.encodeIfPresent(orderStatus, forKey: .orderStatus)
        try container.encodeIfPresent(shippingAddress, forKey: .shippingAddress)
        try container.encodeIfPresent(shippingAddressId, forKey: .shippingAddressId)
        try container.encodeIfPresent(shippingCost, forKey: .shippingCost)
        try container.encodeIfPresent(shippingLabelNumber, forKey: .shippingLabelNumber)
        try container.encodeIfPresent(taxAmount, forKey: .taxAmount)
        try container.encodeIfPresent(totalAmount, forKey: .totalAmount)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? GetOrderResponse else { return false }
      guard self.email == object.email else { return false }
      guard self.orderDateTime == object.orderDateTime else { return false }
      guard self.orderId == object.orderId else { return false }
      guard self.orderItemList == object.orderItemList else { return false }
      guard self.orderStatus == object.orderStatus else { return false }
      guard self.shippingAddress == object.shippingAddress else { return false }
      guard self.shippingAddressId == object.shippingAddressId else { return false }
      guard self.shippingCost == object.shippingCost else { return false }
      guard self.shippingLabelNumber == object.shippingLabelNumber else { return false }
      guard self.taxAmount == object.taxAmount else { return false }
      guard self.totalAmount == object.totalAmount else { return false }
      return true
    }

    public static func == (lhs: GetOrderResponse, rhs: GetOrderResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
