// Subscriber.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

public class Subscriber: _Subscriber {
    
    // Implementation is provided by auto-generated superclass.
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

