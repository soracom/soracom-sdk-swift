// EstimatedOrderModel.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class EstimatedOrderModel: PayloadConvertible {

    /** \u30E1\u30FC\u30EB\u30A2\u30C9\u30EC\u30B9 */
    public var email: String?
    /** \u767A\u6CE8ID */
    public var orderId: String?
    /** \u767A\u6CE8\u5546\u54C1\u30EA\u30B9\u30C8 */
    public var orderItemList: [EstimatedOrderItemModel]?
    /** \u767A\u9001\u5148 */
    public var shippingAddress: ShippingAddressModel?
    /** \u5546\u54C1\u767A\u9001\u5148ID */
    public var shippingAddressId: String?
    /** \u914D\u9001\u6599 */
    public var shippingCost: Double?
    /** \u6D88\u8CBB\u7A0E */
    public var taxAmount: Double?
    /** \u5408\u8A08\u91D1\u984D */
    public var totalAmount: Double?

    public required init(
        email: String? = nil, 
        orderId: String? = nil, 
        orderItemList: [EstimatedOrderItemModel]? = nil, 
        shippingAddress: ShippingAddressModel? = nil, 
        shippingAddressId: String? = nil, 
        shippingCost: Double? = nil, 
        taxAmount: Double? = nil, 
        totalAmount: Double? = nil
    ) {
        self.email = email
        self.orderId = orderId
        self.orderItemList = orderItemList
        self.shippingAddress = shippingAddress
        self.shippingAddressId = shippingAddressId
        self.shippingCost = shippingCost
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.email] = email
        payload[.orderId] = orderId
        payload[.orderItemList] = orderItemList
        payload[.shippingAddress] = shippingAddress
        payload[.shippingAddressId] = shippingAddressId
        payload[.shippingCost] = shippingCost
        payload[.taxAmount] = taxAmount
        payload[.totalAmount] = totalAmount

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.email = payload.getString(.email)
        result.orderId = payload.getString(.orderId)
        result.orderItemList = payload.___SWAGGERER_POSTPROCESS_FIXME_[EstimatedOrderItemModel]___(.orderItemList)
        result.shippingAddress = payload.getShippingAddressModel(.shippingAddress)
        result.shippingAddressId = payload.getString(.shippingAddressId)
        result.shippingCost = payload.getDouble(.shippingCost)
        result.taxAmount = payload.getDouble(.taxAmount)
        result.totalAmount = payload.getDouble(.totalAmount)
        return result
    }

}

public typealias EstimatedOrderModelList = [EstimatedOrderModel]
