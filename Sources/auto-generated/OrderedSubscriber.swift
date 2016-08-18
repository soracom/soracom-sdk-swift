// OrderedSubscriber.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class OrderedSubscriber: PayloadConvertible {

    /** IMSI */
    public var imsi: String?
    /** MSISDN */
    public var msisdn: String?
    /** serialNumber */
    public var serialNumber: String?

    public required init(
        imsi: String? = nil, 
        msisdn: String? = nil, 
        serialNumber: String? = nil
    ) {
        self.imsi = imsi
        self.msisdn = msisdn
        self.serialNumber = serialNumber
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.imsi] = imsi
        payload[.msisdn] = msisdn
        payload[.serialNumber] = serialNumber

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.imsi = payload.getString(.imsi)
        result.msisdn = payload.getString(.msisdn)
        result.serialNumber = payload.getString(.serialNumber)
        return result
    }

}

public typealias OrderedSubscriberList = [OrderedSubscriber]
