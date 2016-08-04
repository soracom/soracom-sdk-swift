// TextStyle.swift Created by mason on 2016-06-18. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

#if os(OSX)

    import Cocoa

#endif


/// TextStyle defines a few custom styles for logging in the SDK demo app

public enum TextStyle {

    case normal, red, blue, green


#if os(OSX)
    
    
    var attributes: [String:AnyObject] {
        switch self {
        case .red:
            return [NSFontAttributeName: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSForegroundColorAttributeName: NSColor.red]
        case .green:
            return [NSFontAttributeName: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSForegroundColorAttributeName: NSColor(red:0.0, green: 0.6, blue: 0.0, alpha: 1.0)]
        case .blue:
            return [NSFontAttributeName: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSForegroundColorAttributeName: NSColor.blue]
        default:
            return [NSFontAttributeName: NSFont.userFixedPitchFont(ofSize: 10.0)!]
        }
    }
    
#else
    
    var attributes: [String:AnyObject] {
        return [:] // for now we don't do color logging except on macOS/OSX
    }
    
#endif

}
