// PayloadConvertible.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// The PayloadConvertible protocol is adopted by model objects and structures that need to be sent back and forth between client and API server.
///
/// Types like Subscriber or AirStats need to implement PayloadConvertible, so that they can provide a Payload representation of themselves that can then be translated to a basic representation that the JSON encoder can deal with it.

protocol PayloadConvertible {
    
    static func from(payload: Payload?) -> Self?
    
    func toPayload() -> Payload

    // NOPE: init?(payload: Payload?)
    //
    // Mason 2016-07-15: This was my first idea, but in Swift 2/3 there is a limitation of
    // the 'memberwise init' automatic initializer, whereby if you implement *any* custom
    // initializer, you no longer get the automatic memberwise one. This is terrible for our
    // use case here, because most of the Soraocm API structures are just dumb structs, but
    // some have a huge number of fields (e.g. Subscriber), which make the memberwise init
    // really convenient.
    //
    // You can work around this by putting all the manual initializers in an extension for each
    // type, but that gets unwieldy so I am just going with a "to/from" pattern for now.
    //
    // The current limitations of Swift memberwise init are known, but not likely to be 
    // addressed soon:
    //
    //  https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20160111/006469.html
    
}


extension PayloadConvertible {
    
    /// A default implementation that does nothing and returns nil.
    ///
    /// This obviously isn't useful for objects that really do need to deserialize an instance from a payload; it's just here to satisfy the protocol conformance requirement for those objects that don't need to. 
    
    static func from(payload: Payload?) -> Self? {
        fatalError("protocol version called bro!") // for now, to help me catch errors
    }

    
    /// Returns an array of instances decoded from `payload` (assuming that `payload` actually encodes an array of the right record type). Returns nil if the root object of `payload` is `nil` or not an array.
    
    static func listFrom(payload: Payload?) -> [Self]? {
        
        guard let root = payload?.toArray() else {
            return nil
        }
        
        var result: [Self] = []
        
        for d in (root as NSArray) {
            if let dict = d as? [String: AnyObject], subload = Payload.fromDictionary(dict) {
                if let c = Self.from(subload) {
                    result.append(c)
                }
            }
        }
        
        return result
    }
    
    // FIXME  should have a generic mechanism to deserialize from a dictionary, so it is not necessary to do "subload = Payload.fromDictionary()" at every single call site. (mason 2016-07-14)

}
