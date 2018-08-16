// BeamCounts.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

extension BeamCounts: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = Int
    
    convenience public init(integerLiteral: BeamCounts.IntegerLiteralType) {
        self.init()
        count = integerLiteral
    }

}


//public class BeamStatsMap: _InsertBeamStatsRequest._BeamStatsMap {
//    
//    /**
//     Convenience constructor, because the API format is unweildy.
//     */
//    public init(inHttp: Int? = nil, inMqtt: Int? = nil, inTcp: Int? = nil, inUdp: Int? = nil, outHttp: Int? = nil, outHttps: Int? = nil, outMqtt: Int? = nil, outMqtts: Int? = nil, outTcp: Int? = nil, outTcps: Int? = nil, outUdp: Int? = nil) {
//        super.init()
//        self.inHttp = BeamCounts(count: inHttp)
//        self.inMqtt = BeamCounts(count: inMqtt)
//        self.inTcp = BeamCounts(count: inTcp)
//        self.inUdp = BeamCounts(count: inUdp)
//        self.outHttp = BeamCounts(count: outHttp)
//        self.outHttps = BeamCounts(count: outHttps)
//        self.outMqtt = BeamCounts(count: outMqtt)
//        self.outMqtts = BeamCounts(count: outMqtts)
//        self.outTcp = BeamCounts(count: outTcp)
//        self.outTcps = BeamCounts(count: outTcps)
//        self.outUdp = BeamCounts(count: outUdp)
//    }
//    
//    public required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//    }
//
//}
