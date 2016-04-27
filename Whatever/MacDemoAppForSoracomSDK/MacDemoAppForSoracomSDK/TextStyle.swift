// TextStyle.swift Created by mason on 2016-03-13. Copyright © 2016 Soracom, Inc. All rights reserved.

import Cocoa

enum TextStyle {
    case Normal, Red, Blue, Green
    
    var attributes: [String:AnyObject] {
        switch self {
        case Red:
            return [NSFontAttributeName: NSFont.userFixedPitchFontOfSize(10.0)!, NSForegroundColorAttributeName: NSColor.redColor()]
        case Green:
            return [NSFontAttributeName: NSFont.userFixedPitchFontOfSize(10.0)!, NSForegroundColorAttributeName: NSColor(red:0.0, green: 0.6, blue: 0.0, alpha: 1.0)]
        case Blue:
            return [NSFontAttributeName: NSFont.userFixedPitchFontOfSize(10.0)!, NSForegroundColorAttributeName: NSColor.blueColor()]
        default:
            return [NSFontAttributeName: NSFont.userFixedPitchFontOfSize(10.0)!]
        }
    }
}

