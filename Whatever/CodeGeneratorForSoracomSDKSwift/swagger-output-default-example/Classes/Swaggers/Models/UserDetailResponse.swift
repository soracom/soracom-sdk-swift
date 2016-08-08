//
// UserDetailResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class UserDetailResponse: JSONEncodable {
    public var authKeyList: [AuthKeyResponse]?
    public var createDateTime: Int?
    public var description: String?
    public var hasPassword: Bool?
    public var permission: String?
    public var roleList: [ListRolesResponse]?
    public var updateDateTime: Int?
    public var userName: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["authKeyList"] = self.authKeyList?.encodeToJSON()
        nillableDictionary["createDateTime"] = self.createDateTime?.encodeToJSON()
        nillableDictionary["description"] = self.description
        nillableDictionary["hasPassword"] = self.hasPassword
        nillableDictionary["permission"] = self.permission
        nillableDictionary["roleList"] = self.roleList?.encodeToJSON()
        nillableDictionary["updateDateTime"] = self.updateDateTime?.encodeToJSON()
        nillableDictionary["userName"] = self.userName
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}