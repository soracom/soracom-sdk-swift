// CouponResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class CouponResponse: PayloadConvertible {

    /** \u30AF\u30FC\u30DD\u30F3\u984D */
    public var amount: Double?
    /** \u6B8B\u9AD8 */
    public var balance: Double?
    /** \u5BFE\u8C61\u8AB2\u91D1\u30A2\u30A4\u30C6\u30E0 */
    public var billItemName: String?
    /** \u30AF\u30FC\u30DD\u30F3\u30B3\u30FC\u30C9 */
    public var couponCode: String?
    /** \u6709\u52B9\u671F\u9650 */
    public var expiryYearMonth: String?

    public required init(
        amount: Double? = nil, 
        balance: Double? = nil, 
        billItemName: String? = nil, 
        couponCode: String? = nil, 
        expiryYearMonth: String? = nil
    ) {
        self.amount = amount
        self.balance = balance
        self.billItemName = billItemName
        self.couponCode = couponCode
        self.expiryYearMonth = expiryYearMonth
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.amount] = amount
        payload[.balance] = balance
        payload[.billItemName] = billItemName
        payload[.couponCode] = couponCode
        payload[.expiryYearMonth] = expiryYearMonth

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.amount = payload.getDouble(.amount)
        result.balance = payload.getDouble(.balance)
        result.billItemName = payload.getString(.billItemName)
        result.couponCode = payload.getString(.couponCode)
        result.expiryYearMonth = payload.getString(.expiryYearMonth)
        return result
    }

}

public typealias CouponResponseList = [CouponResponse]
