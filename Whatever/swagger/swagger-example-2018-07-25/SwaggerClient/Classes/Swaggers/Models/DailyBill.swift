//
// DailyBill.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class DailyBill: Codable {

    /** 金額 */
    public var amount: Int64?
    /** 年月日 */
    public var date: String?


    
    public init(amount: Int64?, date: String?) {
        self.amount = amount
        self.date = date
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(amount, forKey: "amount")
        try container.encodeIfPresent(date, forKey: "date")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        amount = try container.decodeIfPresent(Int64.self, forKey: "amount")
        date = try container.decodeIfPresent(String.self, forKey: "date")
    }
}
