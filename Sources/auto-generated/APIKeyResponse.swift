// APIKeyResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class APIKeyResponse: PayloadConvertible {

    public var apiKey: String?

    public required init(
        apiKey: String? = nil
    ) {
        self.apiKey = apiKey
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.apiKey] = apiKey

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.apiKey = payload.getString(.apiKey)
        return result
    }

}

public typealias APIKeyResponseList = [APIKeyResponse]
