// AttachRoleRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class AttachRoleRequest: PayloadConvertible {

    public var roleId: String?

    public required init(
        roleId: String? = nil
    ) {
        self.roleId = roleId
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.roleId] = roleId

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.roleId = payload.getString(.roleId)
        return result
    }

}

public typealias AttachRoleRequestList = [AttachRoleRequest]
