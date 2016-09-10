// GenerateTokenRequest.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class GenerateTokenRequest: PayloadConvertible {

    /** \u65B0\u3057\u3044 API \u30C8\u30FC\u30AF\u30F3\u306E\u6709\u52B9\u671F\u9650\u306E\u9577\u3055\uFF08\u79D2\u5358\u4F4D\uFF09\u3002\n\u6307\u5B9A\u3057\u306A\u3051\u308C\u3070\u30C7\u30D5\u30A9\u30EB\u30C8\u306F 86400 [\u79D2]\uFF0824\u6642\u9593\uFF09\u3002\n\u6700\u5927\u5024\u306F 172800 [\u79D2]\uFF0848\u6642\u9593\uFF09\u3002\n */
    public var tokenTimeoutSeconds: Int64?

    public required init(
        tokenTimeoutSeconds: Int64? = nil
    ) {
        self.tokenTimeoutSeconds = tokenTimeoutSeconds
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.tokenTimeoutSeconds] = tokenTimeoutSeconds

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.tokenTimeoutSeconds = payload.decodeInt64(.tokenTimeoutSeconds)
        return result
    }

}

public typealias GenerateTokenRequestList = [GenerateTokenRequest]
