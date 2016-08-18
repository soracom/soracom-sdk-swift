// AuthKeyResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class AuthKeyResponse: PayloadConvertible {

    public var authKeyId: String?
    public var createDateTime: Int64?
    public var lastUsedDateTime: Int64?

    public required init(
        authKeyId: String? = nil, 
        createDateTime: Int64? = nil, 
        lastUsedDateTime: Int64? = nil
    ) {
        self.authKeyId = authKeyId
        self.createDateTime = createDateTime
        self.lastUsedDateTime = lastUsedDateTime
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.authKeyId] = authKeyId
        payload[.createDateTime] = createDateTime
        payload[.lastUsedDateTime] = lastUsedDateTime

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.authKeyId = payload.getString(.authKeyId)
        result.createDateTime = payload.getInt64(.createDateTime)
        result.lastUsedDateTime = payload.getInt64(.lastUsedDateTime)
        return result
    }

}

public typealias AuthKeyResponseList = [AuthKeyResponse]
