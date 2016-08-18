// CreateUserPasswordRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class CreateUserPasswordRequest: PayloadConvertible {

    public var password: String?

    public required init(
        password: String? = nil
    ) {
        self.password = password
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.password] = password

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.password = payload.getString(.password)
        return result
    }

}

public typealias CreateUserPasswordRequestList = [CreateUserPasswordRequest]
