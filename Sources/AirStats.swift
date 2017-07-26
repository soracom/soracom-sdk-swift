// AirStats.swift Created by mason on 2017-07-26. 

/// Description forthcoming.

public struct AirStats: PayloadConvertible, Codable {
    
    var dataTrafficStatsMap: DataTrafficStatsMap
    var unixtime: Int    
}
