// GenerateOperatorsAuthKeyResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class GenerateOperatorsAuthKeyResponse: PayloadConvertible {

    public var authKey: String?
    public var authKeyId: String?

    public required init(
        authKey: String? = nil, 
        authKeyId: String? = nil
    ) {
        self.authKey = authKey
        self.authKeyId = authKeyId
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.authKey] = authKey
        payload[.authKeyId] = authKeyId

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.authKey = payload.getString(.authKey)
        result.authKeyId = payload.getString(.authKeyId)
        return result
    }

}

public typealias GenerateOperatorsAuthKeyResponseList = [GenerateOperatorsAuthKeyResponse]
