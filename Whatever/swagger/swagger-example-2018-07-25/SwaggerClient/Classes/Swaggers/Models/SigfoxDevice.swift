//
// SigfoxDevice.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class SigfoxDevice: Codable {

    public enum Status: String, Codable { 
        case active = "active"
        case ready = "ready"
        case terminated = "terminated"
        case instock = "instock"
    }
    public var deviceId: String?
    public var operatorId: String?
    public var groupId: String?
    public var lastModifiedTime: Date?
    public var terminationEnabled: Bool?
    public var status: Status?
    public var lastSeen: LastSeen?
    public var tags: [String:String]?


    
    public init(deviceId: String?, operatorId: String?, groupId: String?, lastModifiedTime: Date?, terminationEnabled: Bool?, status: Status?, lastSeen: LastSeen?, tags: [String:String]?) {
        self.deviceId = deviceId
        self.operatorId = operatorId
        self.groupId = groupId
        self.lastModifiedTime = lastModifiedTime
        self.terminationEnabled = terminationEnabled
        self.status = status
        self.lastSeen = lastSeen
        self.tags = tags
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(deviceId, forKey: "device_id")
        try container.encodeIfPresent(operatorId, forKey: "operatorId")
        try container.encodeIfPresent(groupId, forKey: "groupId")
        try container.encodeIfPresent(lastModifiedTime, forKey: "lastModifiedTime")
        try container.encodeIfPresent(terminationEnabled, forKey: "terminationEnabled")
        try container.encodeIfPresent(status, forKey: "status")
        try container.encodeIfPresent(lastSeen, forKey: "lastSeen")
        try container.encodeIfPresent(tags, forKey: "tags")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        deviceId = try container.decodeIfPresent(String.self, forKey: "device_id")
        operatorId = try container.decodeIfPresent(String.self, forKey: "operatorId")
        groupId = try container.decodeIfPresent(String.self, forKey: "groupId")
        lastModifiedTime = try container.decodeIfPresent(Date.self, forKey: "lastModifiedTime")
        terminationEnabled = try container.decodeIfPresent(Bool.self, forKey: "terminationEnabled")
        status = try container.decodeIfPresent(Status.self, forKey: "status")
        lastSeen = try container.decodeIfPresent(LastSeen.self, forKey: "lastSeen")
        tags = try container.decodeIfPresent([String:String].self, forKey: "tags")
    }
}

