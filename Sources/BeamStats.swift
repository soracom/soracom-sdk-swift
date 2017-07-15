// BeamStats.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// A struct that contains a BeamStats struct, and a timestamp, for use with Request.insertBeamStats()

public struct BeamStatsInsertion: PayloadConvertible, Codable {
    
    var beamStats: BeamStats
    var unixtime: Int
}


// A struct that holds Beam statistics.

public struct BeamStats: PayloadConvertible, Codable {
        
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
    
}
