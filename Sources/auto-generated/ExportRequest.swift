// ExportRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class ExportRequest: PayloadConvertible {

    public enum Period: String { 
        case Month = "month"
        case Day = "day"
        case Minutes = "minutes"
    }
    public var from: Int64?

    public var period: Period?
    public var to: Int64?

    public required init(
        from: Int64? = nil, 
        period: /* FIXME enum wtf */Period = nil, 
        to: Int64? = nil
    ) {
        self.from = from
        self.period = period
        self.to = to
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.from] = from
        // period: FIXME-ENUM-CASE
        payload[.to] = to

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.from = payload.getInt64(.from)
        // period: FIXME-ENUM-CASE
        result.to = payload.getInt64(.to)
        return result
    }

}

public typealias ExportRequestList = [ExportRequest]
