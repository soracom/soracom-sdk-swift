// NSDate+SoracomAPI.swift Created by mason on 2016-06-24. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Date {
    
    /// Init a date instance from an integer representing milliseconds since the beginning of the Unix time epoch (i.e., "milliseconds since 1970" in NSDate parlance).
    
    init(soracomTimestamp: Int64) {
        
        let timeIntervalSince1970 = Double(soracomTimestamp) / 1000.0
        self = Date.init(timeIntervalSince1970: timeIntervalSince1970)
    }
    
    var soracomTimestampValue: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
    
}
