// CreateAndUpdateCredentialsModel.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class CreateAndUpdateCredentialsModel: PayloadConvertible {

    public enum _type: String { 
        case AwsCredentials = "aws-credentials"
        case AzureCredentials = "azure-credentials"
    }
    public var credentials: AnyObject?
    public var description: String?

    public var _type: _type?

    public required init(
        credentials: AnyObject? = nil, 
        description: String? = nil, 
        _type: /* FIXME enum wtf */_type = nil
    ) {
        self.credentials = credentials
        self.description = description
        self._type = _type
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.credentials] = credentials
        payload[.description] = description
        payload[._type] = _type

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.credentials = payload.getAnyObject(.credentials)
        result.description = payload.getString(.description)
        // _type: WHUT FIXME-ENUM-CASE _type
        result._type = payload.get_type(._type)
        return result
    }

}

public typealias CreateAndUpdateCredentialsModelList = [CreateAndUpdateCredentialsModel]
