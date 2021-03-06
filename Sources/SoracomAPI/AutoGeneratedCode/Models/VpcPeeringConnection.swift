//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class VpcPeeringConnection: Codable, Equatable {

    public var destinationCidrBlock: String?

    public var id: String?

    public var peerOwnerId: String?

    public var peerVpcId: String?

    public init(destinationCidrBlock: String? = nil, id: String? = nil, peerOwnerId: String? = nil, peerVpcId: String? = nil) {
        self.destinationCidrBlock = destinationCidrBlock
        self.id = id
        self.peerOwnerId = peerOwnerId
        self.peerVpcId = peerVpcId
    }

    private enum CodingKeys: String, CodingKey {
        case destinationCidrBlock
        case id
        case peerOwnerId
        case peerVpcId
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        destinationCidrBlock = try container.decodeIfPresent(.destinationCidrBlock)
        id = try container.decodeIfPresent(.id)
        peerOwnerId = try container.decodeIfPresent(.peerOwnerId)
        peerVpcId = try container.decodeIfPresent(.peerVpcId)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(destinationCidrBlock, forKey: .destinationCidrBlock)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(peerOwnerId, forKey: .peerOwnerId)
        try container.encodeIfPresent(peerVpcId, forKey: .peerVpcId)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? VpcPeeringConnection else { return false }
      guard self.destinationCidrBlock == object.destinationCidrBlock else { return false }
      guard self.id == object.id else { return false }
      guard self.peerOwnerId == object.peerOwnerId else { return false }
      guard self.peerVpcId == object.peerVpcId else { return false }
      return true
    }

    public static func == (lhs: VpcPeeringConnection, rhs: VpcPeeringConnection) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
