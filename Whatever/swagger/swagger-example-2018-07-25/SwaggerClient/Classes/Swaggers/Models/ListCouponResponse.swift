//
// ListCouponResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class ListCouponResponse: Codable {

    /** クーポンリスト */
    public var couponList: [CouponResponse]?


    
    public init(couponList: [CouponResponse]?) {
        self.couponList = couponList
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(couponList, forKey: "couponList")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        couponList = try container.decodeIfPresent([CouponResponse].self, forKey: "couponList")
    }
}

