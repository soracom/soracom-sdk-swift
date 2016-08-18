// CreateVpcPeeringConnectionRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class CreateVpcPeeringConnectionRequest: PayloadConvertible {

    public var peerOwnerId: String?
    public var peerVpcId: String?
    public var destinationCidrBlock: String?

    public required init(
        peerOwnerId: String? = nil, 
        peerVpcId: String? = nil, 
        destinationCidrBlock: String? = nil
    ) {
        self.peerOwnerId = peerOwnerId
        self.peerVpcId = peerVpcId
        self.destinationCidrBlock = destinationCidrBlock
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.peerOwnerId] = peerOwnerId
        payload[.peerVpcId] = peerVpcId
        payload[.destinationCidrBlock] = destinationCidrBlock

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.peerOwnerId = payload.getString(.peerOwnerId)
        result.peerVpcId = payload.getString(.peerVpcId)
        result.destinationCidrBlock = payload.getString(.destinationCidrBlock)
        return result
    }

}

public typealias CreateVpcPeeringConnectionRequestList = [CreateVpcPeeringConnectionRequest]