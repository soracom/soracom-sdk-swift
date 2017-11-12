// PayloadConvertible.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// The PayloadConvertible protocol is adopted by model objects and structures that need to be sent back and forth between client and API server.
///
/// Types like Subscriber or AirStats need to implement PayloadConvertible, so that they can provide a Payload representation of themselves that can then be translated to a basic representation that the JSON encoder can deal with it.

protocol PayloadConvertible {
    
    static func from(_ payload: Payload?) -> Self?
    
    func toPayload() -> Payload

    // NOPE: init?(payload: Payload?)
    //
    // Mason 2016-07-15: This was my first idea, but in Swift 2/3 there is a limitation of
    // the 'memberwise init' automatic initializer, whereby if you implement *any* custom
    // initializer, you no longer get the automatic memberwise one. This is terrible for our
    // use case here, because most of the Soracom API structures are just dumb structs, but
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
    //
    // UPDATE 2017-07-18: FIXME: Revisit this decision, because Swift 4's awesome new Codable
    // adds a similar initializer via the Decodable protocol: init(from: Decoder)
    //
    // This has the same issues described above, but since we are definitely going to adopt
    // Codable for most or all model objects, the objection is moot. However, Payload itself
    // is due for refactoring/deletion, so I'm not worrying about this now.
}
