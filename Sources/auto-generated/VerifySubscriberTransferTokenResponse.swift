// VerifySubscriberTransferTokenResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class VerifySubscriberTransferTokenResponse: PayloadConvertible {

    /** \u79FB\u7BA1\u3055\u308C\u305FIMSI\u30EA\u30B9\u30C8 */
    public var transferredImsi: [String]?

    public required init(
        transferredImsi: [String]? = nil
    ) {
        self.transferredImsi = transferredImsi
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.transferredImsi] = transferredImsi

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.transferredImsi = payload.getStringArray(.transferredImsi)
        return result
    }

}

public typealias VerifySubscriberTransferTokenResponseList = [VerifySubscriberTransferTokenResponse]
