// BeamCounts+Extras.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

extension BeamCounts: ExpressibleByIntegerLiteral {
    
    public typealias IntegerLiteralType = Int
    
    convenience public init(integerLiteral: BeamCounts.IntegerLiteralType) {
        self.init()
        count = integerLiteral
    }

}
