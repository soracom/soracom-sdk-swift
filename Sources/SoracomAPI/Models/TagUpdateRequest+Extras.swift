// TagUpdateRequest+Extras.swift Created by Mason Mark on 2018-08-21.

/// Convenience extension to make initializing TagUpdateRequest ( and [TagUpdateRequest]) nicer.

extension TagUpdateRequest: ExpressibleByDictionaryLiteral {
    public convenience init(dictionaryLiteral elements: (String, String)...) {
        self.init(tagName: elements[0].0, tagValue: elements[0].1)
    }
    
    public typealias Key = String
    public typealias Value = String
}

extension Array: ExpressibleByDictionaryLiteral where Element == TagUpdateRequest {
    
    public init(dictionaryLiteral elements: (String, String)...) {
        self.init()
        for (k,v) in elements {
            append([k:v])
        }
    }
    
    public typealias Key = String
    
    public typealias Value = String
    
}
