//// RegisterOperatorsRequest.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.
//
//import Foundation
//
//public class RegisterOperatorsRequestFIXME /*: RegisterOperatorsRequest */ {
//
//    open var coverageTypes: [String]?
//    
//    
//    private enum CodingKeys: String, CodingKey {
//        case coverageTypes
//    }
//    
//    public init(email: String, password: String, coverageTypes: [String]?) {
//        super.init(email: email, password: password)
//        self.coverageTypes = coverageTypes
//    }
//
//    public required init(from decoder: Decoder) throws {
//        try super.init(from: decoder)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        coverageTypes = try container.decode(.coverageTypes)
//    }
//    
//    open override func encode(to encoder: Encoder) throws {
//        try super.encode(to: encoder)
//
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        if let coverageTypes = coverageTypes {
//            try container.encode(coverageTypes, forKey: .coverageTypes)
//        }
//    }
//
//    // The base implementation for this class is provided by the
//    // auto-generated superclass (_RegisterOperatorsRequest).
//    //
//    // A lot of code for things like API structures can be generated
//    // automatically from the API specification. Using this "generation
//    // gap" pattern gives us a simple way to have human-edited code for
//    // code documentation and special cases, without having to take extra
//    // steps when the code is regenerated.
//}
