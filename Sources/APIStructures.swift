// APIStructures.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation




public enum TagValueMatchMode: String {
    // Mason 2016-06-08: FIXME: I am making some guesses about how this works and what the legal values are; confirm.
    case exact, prefix
}




/// Defines all valid coverage types

public enum CoverageType: String {
    case japan  = "jp"
    case global = "g"
}

