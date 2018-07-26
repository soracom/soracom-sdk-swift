//
// ListPaymentStatementResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ListPaymentStatementResponse: Codable {

    /** 課金明細リスト */
    public var paymentStatementsList: [PaymentStatementResponse]?


    
    public init(paymentStatementsList: [PaymentStatementResponse]?) {
        self.paymentStatementsList = paymentStatementsList
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(paymentStatementsList, forKey: "paymentStatementsList")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        paymentStatementsList = try container.decodeIfPresent([PaymentStatementResponse].self, forKey: "paymentStatementsList")
    }
}
