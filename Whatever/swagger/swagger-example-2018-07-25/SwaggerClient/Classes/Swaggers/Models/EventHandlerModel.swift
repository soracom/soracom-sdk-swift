//
// EventHandlerModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class EventHandlerModel: Codable {

    public enum Status: String, Codable { 
        case inactive = "inactive"
        case active = "active"
    }
    public var actionConfigList: [ActionConfig]
    public var description: String?
    public var handlerId: String
    public var name: String
    public var ruleConfig: RuleConfig
    public var status: Status
    public var targetGroupId: String?
    public var targetImsi: String?
    public var targetOperatorId: String?
    public var targetTag: Tag?


    
    public init(actionConfigList: [ActionConfig], description: String?, handlerId: String, name: String, ruleConfig: RuleConfig, status: Status, targetGroupId: String?, targetImsi: String?, targetOperatorId: String?, targetTag: Tag?) {
        self.actionConfigList = actionConfigList
        self.description = description
        self.handlerId = handlerId
        self.name = name
        self.ruleConfig = ruleConfig
        self.status = status
        self.targetGroupId = targetGroupId
        self.targetImsi = targetImsi
        self.targetOperatorId = targetOperatorId
        self.targetTag = targetTag
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(actionConfigList, forKey: "actionConfigList")
        try container.encodeIfPresent(description, forKey: "description")
        try container.encode(handlerId, forKey: "handlerId")
        try container.encode(name, forKey: "name")
        try container.encode(ruleConfig, forKey: "ruleConfig")
        try container.encode(status, forKey: "status")
        try container.encodeIfPresent(targetGroupId, forKey: "targetGroupId")
        try container.encodeIfPresent(targetImsi, forKey: "targetImsi")
        try container.encodeIfPresent(targetOperatorId, forKey: "targetOperatorId")
        try container.encodeIfPresent(targetTag, forKey: "targetTag")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        actionConfigList = try container.decode([ActionConfig].self, forKey: "actionConfigList")
        description = try container.decodeIfPresent(String.self, forKey: "description")
        handlerId = try container.decode(String.self, forKey: "handlerId")
        name = try container.decode(String.self, forKey: "name")
        ruleConfig = try container.decode(RuleConfig.self, forKey: "ruleConfig")
        status = try container.decode(Status.self, forKey: "status")
        targetGroupId = try container.decodeIfPresent(String.self, forKey: "targetGroupId")
        targetImsi = try container.decodeIfPresent(String.self, forKey: "targetImsi")
        targetOperatorId = try container.decodeIfPresent(String.self, forKey: "targetOperatorId")
        targetTag = try container.decodeIfPresent(Tag.self, forKey: "targetTag")
    }
}
