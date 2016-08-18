// IssueEmailChangeTokenRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class IssueEmailChangeTokenRequest: PayloadConvertible {

    public var email: String?

    public required init(
        email: String? = nil
    ) {
        self.email = email
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.email] = email

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.email = payload.getString(.email)
        return result
    }

}

public typealias IssueEmailChangeTokenRequestList = [IssueEmailChangeTokenRequest]
