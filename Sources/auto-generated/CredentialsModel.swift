// CredentialsModel.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class CredentialsModel: PayloadConvertible {

    public enum _type: String { 
        case AwsCredentials = "aws-credentials"
        case AzureCredentials = "azure-credentials"
    }
    public var createDateTime: Int64?
    public var credentials: AnyObject?
    public var credentialsId: String?
    public var description: String?
    public var lastUsedDateTime: Int64?

    public var _type: _type?
    public var updateDateTime: Int64?

    public required init(
        createDateTime: Int64? = nil, 
        credentials: AnyObject? = nil, 
        credentialsId: String? = nil, 
        description: String? = nil, 
        lastUsedDateTime: Int64? = nil, 
        _type: _type? = nil, 
        updateDateTime: Int64? = nil
    ) {
        self.createDateTime = createDateTime
        self.credentials = credentials
        self.credentialsId = credentialsId
        self.description = description
        self.lastUsedDateTime = lastUsedDateTime
        self._type = _type
        self.updateDateTime = updateDateTime
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.createDateTime] = createDateTime
        payload[.credentials] = credentials
        payload[.credentialsId] = credentialsId
        payload[.description] = description
        payload[.lastUsedDateTime] = lastUsedDateTime
        payload[._type] = _type
        payload[.updateDateTime] = updateDateTime

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.createDateTime = payload.decodeInt64(.createDateTime)
        result.credentials = payload.decodeAnyObject(.credentials)
        result.credentialsId = payload.decodeString(.credentialsId)
        result.description = payload.decodeString(.description)
        result.lastUsedDateTime = payload.decodeInt64(.lastUsedDateTime)
        result._type = payload.decode_type(._type)
        result.updateDateTime = payload.decodeInt64(.updateDateTime)
        return result
    }

}

public typealias CredentialsModelList = [CredentialsModel]
