// AuthRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class AuthRequest: PayloadConvertible {

    public var authKey: String?
    public var authKeyId: String?
    public var email: String?
    public var operatorId: String?
    public var password: String?
    public var tokenTimeoutSeconds: Int64?
    public var userName: String?

    public required init(
        authKey: String? = nil, 
        authKeyId: String? = nil, 
        email: String? = nil, 
        operatorId: String? = nil, 
        password: String? = nil, 
        tokenTimeoutSeconds: Int64? = nil, 
        userName: String? = nil
    ) {
        self.authKey = authKey
        self.authKeyId = authKeyId
        self.email = email
        self.operatorId = operatorId
        self.password = password
        self.tokenTimeoutSeconds = tokenTimeoutSeconds
        self.userName = userName
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.authKey] = authKey
        payload[.authKeyId] = authKeyId
        payload[.email] = email
        payload[.operatorId] = operatorId
        payload[.password] = password
        payload[.tokenTimeoutSeconds] = tokenTimeoutSeconds
        payload[.userName] = userName

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
        result.email = payload.getString(.email)
        result.operatorId = payload.getString(.operatorId)
        result.password = payload.getString(.password)
        result.tokenTimeoutSeconds = payload.getInt64(.tokenTimeoutSeconds)
        result.userName = payload.getString(.userName)
        return result
    }

}

public typealias AuthRequestList = [AuthRequest]
