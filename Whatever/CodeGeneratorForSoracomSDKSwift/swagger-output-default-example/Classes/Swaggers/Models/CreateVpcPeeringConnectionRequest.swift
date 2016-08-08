//
// CreateVpcPeeringConnectionRequest.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class CreateVpcPeeringConnectionRequest: JSONEncodable {
    public var peerOwnerId: String?
    public var peerVpcId: String?
    public var destinationCidrBlock: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["peerOwnerId"] = self.peerOwnerId
        nillableDictionary["peerVpcId"] = self.peerVpcId
        nillableDictionary["destinationCidrBlock"] = self.destinationCidrBlock
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
