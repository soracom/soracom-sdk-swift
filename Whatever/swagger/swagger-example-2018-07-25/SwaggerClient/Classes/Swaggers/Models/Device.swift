//
// Device.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Device: Codable {

    public var deviceId: String?
    public var operatorId: String?
    public var groupId: String?
    public var lastModifiedTime: Date?
    public var endpoint: String?
    public var registrationId: String?
    public var registrationLifeTime: Int64?
    public var lastRegistrationUpdate: Date?
    public var ipAddress: String?
    public var objects: Any?
    public var tags: [String:String]?
    public var online: Bool?
    public var manufacturer: String?
    public var modelNumber: String?
    public var serialNumber: String?
    public var firmwareVersion: String?


    
    public init(deviceId: String?, operatorId: String?, groupId: String?, lastModifiedTime: Date?, endpoint: String?, registrationId: String?, registrationLifeTime: Int64?, lastRegistrationUpdate: Date?, ipAddress: String?, objects: Any?, tags: [String:String]?, online: Bool?, manufacturer: String?, modelNumber: String?, serialNumber: String?, firmwareVersion: String?) {
        self.deviceId = deviceId
        self.operatorId = operatorId
        self.groupId = groupId
        self.lastModifiedTime = lastModifiedTime
        self.endpoint = endpoint
        self.registrationId = registrationId
        self.registrationLifeTime = registrationLifeTime
        self.lastRegistrationUpdate = lastRegistrationUpdate
        self.ipAddress = ipAddress
        self.objects = objects
        self.tags = tags
        self.online = online
        self.manufacturer = manufacturer
        self.modelNumber = modelNumber
        self.serialNumber = serialNumber
        self.firmwareVersion = firmwareVersion
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(deviceId, forKey: "device_id")
        try container.encodeIfPresent(operatorId, forKey: "operatorId")
        try container.encodeIfPresent(groupId, forKey: "groupId")
        try container.encodeIfPresent(lastModifiedTime, forKey: "lastModifiedTime")
        try container.encodeIfPresent(endpoint, forKey: "endpoint")
        try container.encodeIfPresent(registrationId, forKey: "registrationId")
        try container.encodeIfPresent(registrationLifeTime, forKey: "registrationLifeTime")
        try container.encodeIfPresent(lastRegistrationUpdate, forKey: "lastRegistrationUpdate")
        try container.encodeIfPresent(ipAddress, forKey: "ipAddress")
        try container.encodeIfPresent(objects, forKey: "objects")
        try container.encodeIfPresent(tags, forKey: "tags")
        try container.encodeIfPresent(online, forKey: "online")
        try container.encodeIfPresent(manufacturer, forKey: "manufacturer")
        try container.encodeIfPresent(modelNumber, forKey: "modelNumber")
        try container.encodeIfPresent(serialNumber, forKey: "serialNumber")
        try container.encodeIfPresent(firmwareVersion, forKey: "firmwareVersion")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        deviceId = try container.decodeIfPresent(String.self, forKey: "device_id")
        operatorId = try container.decodeIfPresent(String.self, forKey: "operatorId")
        groupId = try container.decodeIfPresent(String.self, forKey: "groupId")
        lastModifiedTime = try container.decodeIfPresent(Date.self, forKey: "lastModifiedTime")
        endpoint = try container.decodeIfPresent(String.self, forKey: "endpoint")
        registrationId = try container.decodeIfPresent(String.self, forKey: "registrationId")
        registrationLifeTime = try container.decodeIfPresent(Int64.self, forKey: "registrationLifeTime")
        lastRegistrationUpdate = try container.decodeIfPresent(Date.self, forKey: "lastRegistrationUpdate")
        ipAddress = try container.decodeIfPresent(String.self, forKey: "ipAddress")
        objects = try container.decodeIfPresent(Any.self, forKey: "objects")
        tags = try container.decodeIfPresent([String:String].self, forKey: "tags")
        online = try container.decodeIfPresent(Bool.self, forKey: "online")
        manufacturer = try container.decodeIfPresent(String.self, forKey: "manufacturer")
        modelNumber = try container.decodeIfPresent(String.self, forKey: "modelNumber")
        serialNumber = try container.decodeIfPresent(String.self, forKey: "serialNumber")
        firmwareVersion = try container.decodeIfPresent(String.self, forKey: "firmwareVersion")
    }
}

