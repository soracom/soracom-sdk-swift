// PaymentAmount.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class PaymentAmount: PayloadConvertible {

    public var taxAmount: Double?
    public var totalAmount: Double?

    public required init(
        taxAmount: Double? = nil, 
        totalAmount: Double? = nil
    ) {
        self.taxAmount = taxAmount
        self.totalAmount = totalAmount
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

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

        result.taxAmount = payload.getDouble(.taxAmount)
        result.totalAmount = payload.getDouble(.totalAmount)
        return result
    }

}

public typealias PaymentAmountList = [PaymentAmount]