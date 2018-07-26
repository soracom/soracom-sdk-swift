//
// RuleConfig.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RuleConfig: Codable {

    public enum ModelType: String, Codable { 
        case dailyTrafficRule = "DailyTrafficRule"
        case monthlyTrafficRule = "MonthlyTrafficRule"
        case cumulativeTrafficRule = "CumulativeTrafficRule"
        case dailyTotalTrafficRule = "DailyTotalTrafficRule"
        case monthlyTotalTrafficRule = "MonthlyTotalTrafficRule"
        case subscriberStatusAttributeRule = "SubscriberStatusAttributeRule"
        case subscriberSpeedClassAttributeRule = "SubscriberSpeedClassAttributeRule"
        case subscriberExpiredRule = "SubscriberExpiredRule"
    }
    public var properties: RuleConfigProperty
    public var type: ModelType


    
    public init(properties: RuleConfigProperty, type: ModelType) {
        self.properties = properties
        self.type = type
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(properties, forKey: "properties")
        try container.encode(type, forKey: "type")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        properties = try container.decode(RuleConfigProperty.self, forKey: "properties")
        type = try container.decode(ModelType.self, forKey: "type")
    }
}
