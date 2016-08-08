//
// ListProductResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class ListProductResponse: JSONEncodable {
    public var productList: [ProductModel]?
    public var shippingCostList: [ShippingCostModel]?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["productList"] = self.productList?.encodeToJSON()
        nillableDictionary["shippingCostList"] = self.shippingCostList?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}