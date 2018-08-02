// BeamCounts.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

public class BeamCounts: _BeamCounts {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class BeamStatsMap: _InsertBeamStatsRequest._BeamStatsMap {
    
    /**
     Convenience constructor, because the API format is unweildy.
     */
    public init(inHttp: Int? = nil, inMqtt: Int? = nil, inTcp: Int? = nil, inUdp: Int? = nil, outHttp: Int? = nil, outHttps: Int? = nil, outMqtt: Int? = nil, outMqtts: Int? = nil, outTcp: Int? = nil, outTcps: Int? = nil, outUdp: Int? = nil) {
        super.init()
        self.inHttp = BeamCounts(count: inHttp)
        self.inMqtt = BeamCounts(count: inMqtt)
        self.inTcp = BeamCounts(count: inTcp)
        self.inUdp = BeamCounts(count: inUdp)
        self.outHttp = BeamCounts(count: outHttp)
        self.outHttps = BeamCounts(count: outHttps)
        self.outMqtt = BeamCounts(count: outMqtt)
        self.outMqtts = BeamCounts(count: outMqtts)
        self.outTcp = BeamCounts(count: outTcp)
        self.outTcps = BeamCounts(count: outTcps)
        self.outUdp = BeamCounts(count: outUdp)
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

}

public class CreateCouponRequest: _CreateCouponRequest {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class CreateCouponResponse: _CreateCouponResponse {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class  CreateSubscriberResponse : _CreateSubscriberResponse {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class GetSignupTokenRequest: _GetSignupTokenRequest {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}


public class GetSignupTokenResponse: _GetSignupTokenResponse {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}



public class InitRequest: _InitRequest {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class InsertAirStatsRequest: _InsertAirStatsRequest {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}


public class InsertBeamStatsRequest: _InsertBeamStatsRequest {
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AirStatsResponse).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

public class OpenGateRequest: _OpenGateRequest {
    
}
