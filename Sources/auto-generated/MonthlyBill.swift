// MonthlyBill.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class MonthlyBill: PayloadConvertible {

    public enum PaymentStatus: String { 
        case Lessthanminimumcharge = "lessThanMinimumCharge"
        case Paying = "paying"
        case Paid = "paid"
        case Refunding = "refunding"
        case Refunded = "refunded"
        case Fail = "fail"
    }
    /** \u91D1\u984D */
    public var amount: Int64?

    /** \u76F4\u8FD1\u306E\u8AB2\u91D1\u30B9\u30C6\u30FC\u30BF\u30B9 */
    public var paymentStatus: PaymentStatus?
    /** \u8AB2\u91D1\u8A73\u7D30\u53D6\u5F97\u7528\u306EID */
    public var paymentTransactionId: String?
    /** \u5E74\u6708 */
    public var yearMonth: String?

    public required init(
        amount: Int64? = nil, 
        paymentStatus: PaymentStatus? = nil, 
        paymentTransactionId: String? = nil, 
        yearMonth: String? = nil
    ) {
        self.amount = amount
        self.paymentStatus = paymentStatus
        self.paymentTransactionId = paymentTransactionId
        self.yearMonth = yearMonth
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.amount] = amount
        payload[.paymentStatus] = paymentStatus
        payload[.paymentTransactionId] = paymentTransactionId
        payload[.yearMonth] = yearMonth

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.amount = payload.decodeInt64(.amount)
        result.paymentStatus = payload.decodePaymentStatus(.paymentStatus)
        result.paymentTransactionId = payload.decodeString(.paymentTransactionId)
        result.yearMonth = payload.decodeString(.yearMonth)
        return result
    }

}

public typealias MonthlyBillList = [MonthlyBill]
