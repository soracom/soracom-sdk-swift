// VpcPeeringConnection.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

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

        result.id = payload.decodeString(.id)
        result.peerOwnerId = payload.decodeString(.peerOwnerId)
        result.peerVpcId = payload.decodeString(.peerVpcId)
        result.destinationCidrBlock = payload.decodeString(.destinationCidrBlock)
        return result
    }

}

public typealias VpcPeeringConnectionList = [VpcPeeringConnection]
