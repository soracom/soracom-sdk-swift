// SessionEvent.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class SessionEvent: PayloadConvertible {

    public var operatorId: String?
    public var imsi: String?
    public var time: Int64?
    public var event: String?
    public var imei: String?
    public var ueIpAddress: String?
    public var apn: String?
    public var dns0: String?
    public var dns1: String?
    public var vpgId: String?
    public var gatewayPrivateIpAddress: String?
    public var gatewayPublicIpAddress: String?

    public required init(
        operatorId: String? = nil, 
        imsi: String? = nil, 
        time: Int64? = nil, 
        event: String? = nil, 
        imei: String? = nil, 
        ueIpAddress: String? = nil, 
        apn: String? = nil, 
        dns0: String? = nil, 
        dns1: String? = nil, 
        vpgId: String? = nil, 
        gatewayPrivateIpAddress: String? = nil, 
        gatewayPublicIpAddress: String? = nil
    ) {
        self.operatorId = operatorId
        self.imsi = imsi
        self.time = time
        self.event = event
        self.imei = imei
        self.ueIpAddress = ueIpAddress
        self.apn = apn
        self.dns0 = dns0
        self.dns1 = dns1
        self.vpgId = vpgId
        self.gatewayPrivateIpAddress = gatewayPrivateIpAddress
        self.gatewayPublicIpAddress = gatewayPublicIpAddress
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.operatorId] = operatorId
        payload[.imsi] = imsi
        payload[.time] = time
        payload[.event] = event
        payload[.imei] = imei
        payload[.ueIpAddress] = ueIpAddress
        payload[.apn] = apn
        payload[.dns0] = dns0
        payload[.dns1] = dns1
        payload[.vpgId] = vpgId
        payload[.gatewayPrivateIpAddress] = gatewayPrivateIpAddress
        payload[.gatewayPublicIpAddress] = gatewayPublicIpAddress

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.operatorId = payload.decodeString(.operatorId)
        result.imsi = payload.decodeString(.imsi)
        result.time = payload.decodeInt64(.time)
        result.event = payload.decodeString(.event)
        result.imei = payload.decodeString(.imei)
        result.ueIpAddress = payload.decodeString(.ueIpAddress)
        result.apn = payload.decodeString(.apn)
        result.dns0 = payload.decodeString(.dns0)
        result.dns1 = payload.decodeString(.dns1)
        result.vpgId = payload.decodeString(.vpgId)
        result.gatewayPrivateIpAddress = payload.decodeString(.gatewayPrivateIpAddress)
        result.gatewayPublicIpAddress = payload.decodeString(.gatewayPublicIpAddress)
        return result
    }

}

public typealias SessionEventList = [SessionEvent]
