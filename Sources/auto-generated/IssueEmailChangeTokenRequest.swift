// IssueEmailChangeTokenRequest.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

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

        result.email = payload.decodeString(.email)
        return result
    }

}

public typealias IssueEmailChangeTokenRequestList = [IssueEmailChangeTokenRequest]
