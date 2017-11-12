// Subscriber.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

public struct Subscriber: PayloadConvertible, Codable {
    
    var ipAddress: String?
    var speedClass: String?
    var imsi: String?
    
    // FIXME: to be real we need to support all of this:
    
    //    {
    //    "ipAddress" : "10.48.37.87",
    //    "moduleType" : "nano",
    //    "status" : "ready",
    //    "plan" : 0,
    //    "imsi" : "001010929605213",
    //    "tags" : {
    //
    //    },
    //    "speedClass" : "s1.fast",
    //    "expiryAction" : null,
    //    "sessionStatus" : {
    //    "ueIpAddress" : null,
    //    "online" : false,
    //    "lastUpdatedAt" : 1465374445531,
    //    "dnsServers" : null,
    //    "location" : null,
    //    "imei" : null
    //    },
    //    "createdAt" : 1465374445530,
    //    "lastModifiedTime" : 1465374445593,
    //    "operatorId" : "OP0060667224",
    //    "type" : "s1.fast",
    //    "apn" : "soracom-sandbox.io",
    //    "createdTime" : 1465374445530,
    //    "terminationEnabled" : false,
    //    "serialNumber" : "TS2142687158193",
    //    "groupId" : null,
    //    "expiryTime" : null,
    //    "lastModifiedAt" : 1465374445593,
    //    "msisdn" : "999949175086",
    //    "expiredAt" : null
    //    }
}

public typealias SubscriberList = [Subscriber]


public enum SpeedClass: String {
    case s1_fast     = "s1.fast"
    case s1_minimum  = "s1.minimum"
    case s1_slow     = "s1.slow"
    case s1_standard = "s1.standard"
}


public enum SubscriberStatus: String {
    case active, inactive, ready, instock, shipped, suspended, terminated
}

