// Subscriber.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

public class Subscriber: _Subscriber {

    // The base implementation for this class is provided by the
    // auto-generated superclass (_Subscriber).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
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

