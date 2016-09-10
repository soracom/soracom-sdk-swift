// GetBillingHistoryResponse.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class GetBillingHistoryResponse: PayloadConvertible {

    /** \u6708\u3054\u3068\u306E\u5229\u7528\u6599\u30EA\u30B9\u30C8 */
    public var billList: [MonthlyBill]?

    public required init(
        billList: [MonthlyBill]? = nil
    ) {
        self.billList = billList
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.billList] = billList

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.billList = payload.decodeMonthlyBill(.billList)
        return result
    }

}

public typealias GetBillingHistoryResponseList = [GetBillingHistoryResponse]
