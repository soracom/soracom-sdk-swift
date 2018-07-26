//
// RuleConfigProperty.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RuleConfigProperty: Codable {

    public enum InactiveTimeoutDateConst: String, Codable { 
        case immediately = "IMMEDIATELY"
        case beginningOfNextMonth = "BEGINNING_OF_NEXT_MONTH"
        case beginningOfNextDay = "BEGINNING_OF_NEXT_DAY"
        case afterOneDay = "AFTER_ONE_DAY"
        case never = "NEVER"
    }
    public enum TargetStatus: String, Codable { 
        case ready = "ready"
        case active = "active"
        case inactive = "inactive"
        case suspended = "suspended"
        case terminated = "terminated"
    }
    public enum TargetSpeedClass: String, Codable { 
        case minimum = "s1.minimum"
        case slow = "s1.slow"
        case standard = "s1.standard"
        case fast = "s1.fast"
    }
    public var limitTotalTrafficMegaByte: Int
    public var inactiveTimeoutDateConst: InactiveTimeoutDateConst?
    /** SubscriberStatusAttributeRule の時のみ有効 */
    public var targetStatus: TargetStatus?
    /** SubscriberSpeedClassAttributeRule の時のみ有効 */
    public var targetSpeedClass: TargetSpeedClass?


    
    public init(limitTotalTrafficMegaByte: Int, inactiveTimeoutDateConst: InactiveTimeoutDateConst?, targetStatus: TargetStatus?, targetSpeedClass: TargetSpeedClass?) {
        self.limitTotalTrafficMegaByte = limitTotalTrafficMegaByte
        self.inactiveTimeoutDateConst = inactiveTimeoutDateConst
        self.targetStatus = targetStatus
        self.targetSpeedClass = targetSpeedClass
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(limitTotalTrafficMegaByte, forKey: "limitTotalTrafficMegaByte")
        try container.encodeIfPresent(inactiveTimeoutDateConst, forKey: "inactiveTimeoutDateConst")
        try container.encodeIfPresent(targetStatus, forKey: "targetStatus")
        try container.encodeIfPresent(targetSpeedClass, forKey: "targetSpeedClass")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        limitTotalTrafficMegaByte = try container.decode(Int.self, forKey: "limitTotalTrafficMegaByte")
        inactiveTimeoutDateConst = try container.decodeIfPresent(InactiveTimeoutDateConst.self, forKey: "inactiveTimeoutDateConst")
        targetStatus = try container.decodeIfPresent(TargetStatus.self, forKey: "targetStatus")
        targetSpeedClass = try container.decodeIfPresent(TargetSpeedClass.self, forKey: "targetSpeedClass")
    }
}
