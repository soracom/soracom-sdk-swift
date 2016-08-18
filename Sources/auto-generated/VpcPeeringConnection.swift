// VpcPeeringConnection.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class VpcPeeringConnection: PayloadConvertible {

    public var id: String?
    public var peerOwnerId: String?
    public var peerVpcId: String?
    public var destinationCidrBlock: String?

    public required init(
        id: String? = nil, 
        peerOwnerId: String? = nil, 
        peerVpcId: String? = nil, 
        destinationCidrBlock: String? = nil
    ) {
        self.id = id
        self.peerOwnerId = peerOwnerId
        self.peerVpcId = peerVpcId
        self.destinationCidrBlock = destinationCidrBlock
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.id] = id
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

        result.id = payload.getString(.id)
        result.peerOwnerId = payload.getString(.peerOwnerId)
        result.peerVpcId = payload.getString(.peerVpcId)
        result.destinationCidrBlock = payload.getString(.destinationCidrBlock)
        return result
    }

}

public typealias VpcPeeringConnectionList = [VpcPeeringConnection]
