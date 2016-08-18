// RegisterOperatorsRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class RegisterOperatorsRequest: PayloadConvertible {

    public var email: String?
    /** \u30D1\u30B9\u30EF\u30FC\u30C9\u306F\u4EE5\u4E0B\u306E\u6761\u4EF6\u3092\u6E80\u305F\u3057\u3066\u3044\u308B\u5FC5\u8981\u304C\u3042\u308A\u307E\u3059\uFF1A\u9577\u3055 8 \u6587\u5B57\u4EE5\u4E0A100 \u6587\u5B57\u4EE5\u5185\u3001\u30A2\u30EB\u30D5\u30A1\u30D9\u30C3\u30C8\u5C0F\u6587\u5B57 (a-z) \u3092 1 \u6587\u5B57\u4EE5\u4E0A\u4F7F\u7528\u3001\u30A2\u30EB\u30D5\u30A1\u30D9\u30C3\u30C8\u5927\u6587\u5B57 (A-Z) \u3092 1 \u6587\u5B57\u4EE5\u4E0A\u4F7F\u7528\u3001\u6570\u5B57\u3092 1 \u6587\u5B57\u4EE5\u4E0A\u4F7F\u7528\u3002\u8A18\u53F7\u306A\u3069\u3082\u4F7F\u7528\u3067\u304D\u307E\u3059\u3002 */
    public var password: String?

    public required init(
        email: String? = nil, 
        password: String? = nil
    ) {
        self.email = email
        self.password = password
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.email] = email
        payload[.password] = password

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.email = payload.getString(.email)
        result.password = payload.getString(.password)
        return result
    }

}

public typealias RegisterOperatorsRequestList = [RegisterOperatorsRequest]
