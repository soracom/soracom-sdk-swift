//
// AuthResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class AuthResponse: JSONEncodable {
    public var apiKey: String?
    public var operatorId: String?
    public var token: String?
    public var userName: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["apiKey"] = self.apiKey
        nillableDictionary["operatorId"] = self.operatorId
        nillableDictionary["token"] = self.token
        nillableDictionary["userName"] = self.userName
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
