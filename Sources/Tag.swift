// Tag.swift Created by mason on 2017-07-26. 

public struct Tag: PayloadConvertible, Codable {
    
    var tagName: String
    var tagValue: String
}

public typealias TagList = [Tag]
