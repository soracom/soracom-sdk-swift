//
// EstimatedOrderItemModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class EstimatedOrderItemModel: JSONEncodable {
    /** \u5546\u54C1 */
    public var product: ProductModel?
    /** \u5546\u54C1\u91D1\u984D */
    public var productAmount: Double?
    /** \u8CFC\u5165\u6570 */
    public var quantity: Int?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["product"] = self.product?.encodeToJSON()
        nillableDictionary["productAmount"] = self.productAmount
        nillableDictionary["quantity"] = self.quantity?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
