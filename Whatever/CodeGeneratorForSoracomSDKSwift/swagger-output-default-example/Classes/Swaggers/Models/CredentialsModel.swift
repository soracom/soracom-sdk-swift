//
// CredentialsModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class CredentialsModel: JSONEncodable {
    public enum _type: String { 
        case AwsCredentials = "aws-credentials"
        case AzureCredentials = "azure-credentials"
    }
    public var createDateTime: Int?
    public var credentials: AnyObject?
    public var credentialsId: String?
    public var description: String?
    public var lastUsedDateTime: Int?
    public var _type: _type?
    public var updateDateTime: Int?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["createDateTime"] = self.createDateTime?.encodeToJSON()
        nillableDictionary["credentials"] = self.credentials
        nillableDictionary["credentialsId"] = self.credentialsId
        nillableDictionary["description"] = self.description
        nillableDictionary["lastUsedDateTime"] = self.lastUsedDateTime?.encodeToJSON()
        nillableDictionary["type"] = self._type?.rawValue
        nillableDictionary["updateDateTime"] = self.updateDateTime?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}