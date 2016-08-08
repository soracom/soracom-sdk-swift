//
// ListOrderResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class ListOrderResponse: JSONEncodable {
    /** \u767A\u6CE8\u30EA\u30B9\u30C8 */
    public var orderList: [GetOrderResponse]?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["orderList"] = self.orderList?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
