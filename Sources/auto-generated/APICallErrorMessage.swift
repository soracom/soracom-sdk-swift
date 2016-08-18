// APICallErrorMessage.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class APICallErrorMessage: PayloadConvertible {

    /** \u30A8\u30E9\u30FC\u30B3\u30FC\u30C9 */
    public var code: String?
    /** \u30A8\u30E9\u30FC\u30E1\u30C3\u30BB\u30FC\u30B8\u3002\u30EA\u30AF\u30A8\u30B9\u30C8\u6642\u306BX-Soracom-Lang\u30D8\u30C3\u30C0\u30FC\u306B\u8A00\u8A9E(en,ja)\u3092\u8A2D\u5B9A\u3059\u308B\u3068\u305D\u306E\u8A00\u8A9E\u306E\u30E1\u30C3\u30BB\u30FC\u30B8\u304C\u30BB\u30C3\u30C8\u3055\u308C\u307E\u3059\u3002 */
    public var message: String?

    public required init(
        code: String? = nil, 
        message: String? = nil
    ) {
        self.code = code
        self.message = message
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.code] = code
        payload[.message] = message

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.code = payload.getString(.code)
        result.message = payload.getString(.message)
        return result
    }

}

public typealias APICallErrorMessageList = [APICallErrorMessage]