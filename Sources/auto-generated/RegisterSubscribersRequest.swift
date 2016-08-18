// RegisterSubscribersRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class RegisterSubscribersRequest: PayloadConvertible {

    public var registrationSecret: String?
    public var groupId: String?
    public var tags: [TagUpdateRequest]?

    public required init(
        registrationSecret: String? = nil, 
        groupId: String? = nil, 
        tags: [TagUpdateRequest]? = nil
    ) {
        self.registrationSecret = registrationSecret
        self.groupId = groupId
        self.tags = tags
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.registrationSecret] = registrationSecret
        payload[.groupId] = groupId
        payload[.tags] = tags

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.registrationSecret = payload.getString(.registrationSecret)
        result.groupId = payload.getString(.groupId)
        result.tags = payload.___SWAGGERER_POSTPROCESS_FIXME_[TagUpdateRequest]___(.tags)
        return result
    }

}

public typealias RegisterSubscribersRequestList = [RegisterSubscribersRequest]
