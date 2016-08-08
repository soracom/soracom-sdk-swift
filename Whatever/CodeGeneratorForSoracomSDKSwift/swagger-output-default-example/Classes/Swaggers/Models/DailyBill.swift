//
// DailyBill.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class DailyBill: JSONEncodable {
    /** \u91D1\u984D */
    public var amount: Int?
    /** \u5E74\u6708\u65E5 */
    public var date: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["amount"] = self.amount?.encodeToJSON()
        nillableDictionary["date"] = self.date
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
