// ExpiryTime.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class ExpiryTime: PayloadConvertible {

    public enum ExpiryAction: String { 
        case Donothing = "doNothing"
        case Deletesession = "deleteSession"
        case Deactivate = "deactivate"
        case Terminate = "terminate"
    }
    public var expiryTime: Int64?

    public var expiryAction: ExpiryAction?

    public required init(
        expiryTime: Int64? = nil, 
        expiryAction: /* FIXME enum wtf */ExpiryAction = nil
    ) {
        self.expiryTime = expiryTime
        self.expiryAction = expiryAction
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.expiryTime] = expiryTime
        payload[.expiryAction] = expiryAction

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.expiryTime = payload.getInt64(.expiryTime)
        // expiryAction: WHUT FIXME-ENUM-CASE ExpiryAction
        result.expiryAction = payload.getExpiryAction(.expiryAction)
        return result
    }

}

public typealias ExpiryTimeList = [ExpiryTime]
