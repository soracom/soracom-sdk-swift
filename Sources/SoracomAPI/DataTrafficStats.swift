// DataTrafficStatsMap.swift Created by mason on 2017-07-26.

// FIXME: check this model; it might actually need arbitrary string keys, not just the 4 defined here

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
