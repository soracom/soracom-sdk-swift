// RoleResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class RoleResponse: PayloadConvertible {

    public var createDateTime: Int64?
    public var description: String?
    /** Permission\u306EJSON */
    public var permission: String?
    public var roleId: String?
    public var updateDateTime: Int64?

    public required init(
        createDateTime: Int64? = nil, 
        description: String? = nil, 
        permission: String? = nil, 
        roleId: String? = nil, 
        updateDateTime: Int64? = nil
    ) {
        self.createDateTime = createDateTime
        self.description = description
        self.permission = permission
        self.roleId = roleId
        self.updateDateTime = updateDateTime
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.createDateTime] = createDateTime
        payload[.description] = description
        payload[.permission] = permission
        payload[.roleId] = roleId
        payload[.updateDateTime] = updateDateTime

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.createDateTime = payload.getInt64(.createDateTime)
        result.description = payload.getString(.description)
        result.permission = payload.getString(.permission)
        result.roleId = payload.getString(.roleId)
        result.updateDateTime = payload.getInt64(.updateDateTime)
        return result
    }

}

public typealias RoleResponseList = [RoleResponse]