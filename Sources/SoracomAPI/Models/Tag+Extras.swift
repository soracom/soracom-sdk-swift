// Tag.swift Created by mason on 2017-07-26. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

public typealias TagList = [Tag]

public enum TagValueMatchMode: String {
    // Mason 2016-06-08: FIXME: I am making some guesses about how this works and what the legal values are; confirm.
    case exact, prefix
}
