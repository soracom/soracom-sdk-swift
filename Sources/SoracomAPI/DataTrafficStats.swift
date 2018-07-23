// DataTrafficStats.swift Created by mason on 2017-07-26. 

/// Description forthcoming.

public struct DataTrafficStats:  Codable {
    
    var downloadByteSizeTotal: Int   = 0
    var downloadPacketSizeTotal: Int = 0
    var uploadByteSizeTotal: Int     = 0
    var uploadPacketSizeTotal: Int   = 0    
}


/// Description forthcoming.

public struct DataTrafficStatsMap:  Codable {
    
    var s1_fast: DataTrafficStats? = nil
    var s1_minimum: DataTrafficStats? = nil 
    var s1_slow: DataTrafficStats? = nil
    var s1_standard: DataTrafficStats? = nil 
    
    enum CodingKeys: String, CodingKey {
        case s1_fast     = "s1.fast"
        case s1_minimum  = "s1.minimum"
        case s1_slow     = "s1.slow"
        case s1_standard = "s1.standard"
    }
}
