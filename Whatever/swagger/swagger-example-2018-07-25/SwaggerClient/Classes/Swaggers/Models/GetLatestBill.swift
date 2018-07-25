//
// GetLatestBill.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class GetLatestBill: Codable {

    /** 金額 */
    public var amount: Int64?
    /** 利用額計算を実施した時間 */
    public var lastEvaluatedTime: String?


    
    public init(amount: Int64?, lastEvaluatedTime: String?) {
        self.amount = amount
        self.lastEvaluatedTime = lastEvaluatedTime
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(amount, forKey: "amount")
        try container.encodeIfPresent(lastEvaluatedTime, forKey: "lastEvaluatedTime")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        amount = try container.decodeIfPresent(Int64.self, forKey: "amount")
        lastEvaluatedTime = try container.decodeIfPresent(String.self, forKey: "lastEvaluatedTime")
    }
}

