// UpdatePasswordRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class UpdatePasswordRequest: PayloadConvertible {

    public var currentPassword: String?
    public var newPassword: String?

    public required init(
        currentPassword: String? = nil, 
        newPassword: String? = nil
    ) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.currentPassword] = currentPassword
        payload[.newPassword] = newPassword

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.currentPassword = payload.getString(.currentPassword)
        result.newPassword = payload.getString(.newPassword)
        return result
    }

}

public typealias UpdatePasswordRequestList = [UpdatePasswordRequest]