// Subscriber.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation


public typealias SubscriberList = [Subscriber]


public enum SpeedClass: String {
    case s1_fast     = "s1.fast"
    case s1_minimum  = "s1.minimum"
    case s1_slow     = "s1.slow"
    case s1_standard = "s1.standard"
    
    /**
     Returns a string suitable for passing as API query parameter, e.g. "s1.fast|s1.standard"
     */
    static func queryValue(_ status: [SpeedClass]?) -> String? {
        
        guard let status = status else {
            return nil
        }
        var statuses: [String] = []
        for s in status {
            statuses.append(s.rawValue)
        }
        return statuses.joined(separator: "|")
    }

}


public enum SubscriberStatus: String {
    
    case active, inactive, ready, instock, shipped, suspended, terminated

    /**
     Returns a string suitable for passing as API query parameter, e.g. "active|inactive"
     */
    static func queryValue(_ status: [SubscriberStatus]?) -> String? {
        
        guard let status = status else {
            return nil
        }
        var statuses: [String] = []
        for s in status {
            statuses.append(s.rawValue)
        }
        return statuses.joined(separator: "|")
    }
}
