// BeamStats.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

// A struct that contains a BeamStats struct, and a timestamp, for use with Request.insertBeamStats()

public struct BeamStatsInsertion: PayloadConvertible {
    
    var beamStats: BeamStats
    var unixtime: Int
    
    func toPayload() -> Payload {
        let result: Payload = [.unixtime: unixtime]
        result[.beamStatsMap] = beamStats.toPayload()
        return result
    }
}


// A struct that holds Beam statistics.

public struct BeamStats: PayloadConvertible {
    
    // FIXME: It would be nice if we could just use Swift.Int here, because Int is automagically bridged to NSNumber
    // and so we can just stick an Int into a Payload. However, we need to support 32-bit platforms, too, so I think
    // we need to change all the below to Int64, and then explicitly convert to NSNumber ourselves in toPayload()...
    
    var inHttp: Int
    var inMqtt: Int
    var inTcp: Int
    var inUdp: Int
    var outHttp: Int
    var outHttps: Int
    var outMqtt: Int
    var outMqtts: Int
    var outTcp: Int
    var outTcps: Int
    var outUdp: Int
    
    public func toPayload() -> Payload {
        return [
            .inHttp   : inHttp,
            .inMqtt   : inMqtt,
            .inTcp    : inTcp,
            .inUdp    : inUdp,
            .outHttp  : outHttp,
            .outHttps : outHttps,
            .outMqtt  : outMqtt,
            .outMqtts : outMqtts,
            .outTcp   : outTcp,
            .outTcps  : outTcps,
            .outUdp   : outUdp
        ]
    }
    
    public static func from(payload: Payload?) -> BeamStats? {
        
        guard let payload = payload else {
            return nil
        }
        
        guard let inHttp   = payload[.inHttp]   as? Int,
                  inMqtt   = payload[.inMqtt]   as? Int,
                  inTcp    = payload[.inTcp]    as? Int,
                  inUdp    = payload[.inUdp]    as? Int,
                  outHttp  = payload[.outHttp]  as? Int,
                  outHttps = payload[.outHttps] as? Int,
                  outMqtt  = payload[.outMqtt]  as? Int,
                  outMqtts = payload[.outMqtts] as? Int,
                  outTcp   = payload[.outTcp]   as? Int,
                  outTcps  = payload[.outTcps]  as? Int,
                  outUdp   = payload[.outUdp]   as? Int
        else {
            return nil
        }
        
        return BeamStats(inHttp: inHttp, inMqtt: inMqtt, inTcp: inTcp, inUdp: inUdp, outHttp: outHttp, outHttps: outHttps, outMqtt: outMqtt, outMqtts: outMqtts, outTcp: outTcp, outTcps: outTcps, outUdp: outUdp)
    }
}
