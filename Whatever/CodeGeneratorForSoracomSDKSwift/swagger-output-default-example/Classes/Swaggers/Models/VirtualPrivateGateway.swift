//
// VirtualPrivateGateway.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class VirtualPrivateGateway: JSONEncodable {
    public enum PrimaryServiceName: String { 
        case Canal = "Canal"
        case Direct = "Direct"
        case Door = "Door"
        case Gate = "Gate"
    }
    public var operatorId: String?
    public var id: String?
    public var primaryServiceName: PrimaryServiceName?
    public var _type: Int?
    public var status: String?
    public var useInternetGateway: Bool?
    public var vpcPeeringConnections: Map?
    public var virtualInterfaces: Map?
    public var createdTime: Int?
    public var lastModifiedTime: Int?
    public var tags: Tag?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["operatorId"] = self.operatorId
        nillableDictionary["id"] = self.id
        nillableDictionary["primaryServiceName"] = self.primaryServiceName?.rawValue
        nillableDictionary["type"] = self._type
        nillableDictionary["status"] = self.status
        nillableDictionary["useInternetGateway"] = self.useInternetGateway
        nillableDictionary["vpcPeeringConnections"] = self.vpcPeeringConnections?.encodeToJSON()
        nillableDictionary["virtualInterfaces"] = self.virtualInterfaces?.encodeToJSON()
        nillableDictionary["createdTime"] = self.createdTime?.encodeToJSON()
        nillableDictionary["lastModifiedTime"] = self.lastModifiedTime?.encodeToJSON()
        nillableDictionary["tags"] = self.tags?.encodeToJSON()
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
