// DailyBill.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class DailyBill: PayloadConvertible {

    /** \u91D1\u984D */
    public var amount: Int64?
    /** \u5E74\u6708\u65E5 */
    public var date: String?

    public required init(
        amount: Int64? = nil, 
        date: String? = nil
    ) {
        self.amount = amount
        self.date = date
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.amount] = amount
        payload[.date] = date

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.amount = payload.getInt64(.amount)
        result.date = payload.getString(.date)
        return result
    }

}

public typealias DailyBillList = [DailyBill]