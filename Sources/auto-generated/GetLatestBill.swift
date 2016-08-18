// GetLatestBill.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class GetLatestBill: PayloadConvertible {

    /** \u91D1\u984D */
    public var amount: Int64?
    /** \u5229\u7528\u984D\u8A08\u7B97\u3092\u5B9F\u65BD\u3057\u305F\u6642\u9593 */
    public var lastEvaluatedTime: String?

    public required init(
        amount: Int64? = nil, 
        lastEvaluatedTime: String? = nil
    ) {
        self.amount = amount
        self.lastEvaluatedTime = lastEvaluatedTime
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.amount] = amount
        payload[.lastEvaluatedTime] = lastEvaluatedTime

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.amount = payload.getInt64(.amount)
        result.lastEvaluatedTime = payload.getString(.lastEvaluatedTime)
        return result
    }

}

public typealias GetLatestBillList = [GetLatestBill]
