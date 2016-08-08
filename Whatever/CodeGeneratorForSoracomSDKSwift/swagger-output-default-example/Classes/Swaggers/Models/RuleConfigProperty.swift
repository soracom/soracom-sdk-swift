//
// RuleConfigProperty.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class RuleConfigProperty: JSONEncodable {
    public enum InactiveTimeoutDateConst: String { 
        case Immediately = "IMMEDIATELY"
        case BeginningOfNextMonth = "BEGINNING_OF_NEXT_MONTH"
        case BeginningOfNextDay = "BEGINNING_OF_NEXT_DAY"
        case AfterOneDay = "AFTER_ONE_DAY"
        case Never = "NEVER"
    }
    public enum TargetStatus: String { 
        case Ready = "ready"
        case Active = "active"
        case Inactive = "inactive"
        case Suspended = "suspended"
        case Terminated = "terminated"
    }
    public enum TargetSpeedClass: String { 
        case S1.minimum = "s1.minimum"
        case S1.slow = "s1.slow"
        case S1.standard = "s1.standard"
        case S1.fast = "s1.fast"
    }
    public var limitTotalTrafficMegaByte: Int?
    public var inactiveTimeoutDateConst: InactiveTimeoutDateConst?
    /** SubscriberStatusAttributeRule \u306E\u6642\u306E\u307F\u6709\u52B9 */
    public var targetStatus: TargetStatus?
    /** SubscriberSpeedClassAttributeRule \u306E\u6642\u306E\u307F\u6709\u52B9 */
    public var targetSpeedClass: TargetSpeedClass?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["limitTotalTrafficMegaByte"] = self.limitTotalTrafficMegaByte
        nillableDictionary["inactiveTimeoutDateConst"] = self.inactiveTimeoutDateConst?.rawValue
        nillableDictionary["targetStatus"] = self.targetStatus?.rawValue
        nillableDictionary["targetSpeedClass"] = self.targetSpeedClass?.rawValue
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
