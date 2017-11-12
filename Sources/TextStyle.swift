// TextStyle.swift Created by mason on 2016-06-18. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

#if os(OSX)

    import Cocoa

#endif


/// TextStyle defines a few custom styles for logging in the SDK demo app

public enum TextStyle {

    case normal, red, blue, green


#if os(OSX)
    
    
    var attributes: [NSAttributedStringKey:AnyObject] {
        switch self {
        case .red:
            return [NSAttributedStringKey.font: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSAttributedStringKey.foregroundColor: NSColor.red]
        case .green:
            return [NSAttributedStringKey.font: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSAttributedStringKey.foregroundColor: NSColor(red:0.0, green: 0.6, blue: 0.0, alpha: 1.0)]
        case .blue:
            return [NSAttributedStringKey.font: NSFont.userFixedPitchFont(ofSize: 10.0)!, NSAttributedStringKey.foregroundColor: NSColor.blue]
        default:
            return [NSAttributedStringKey.font: NSFont.userFixedPitchFont(ofSize: 10.0)!]
        }
        // FIXME: It doesn't really make sense to have this level of styling info outside of the demo apps.
        // Probably these labels should be more conceptual (.info/.success/.failure or something, and the
        // visual styles should not be defined here.
    }
    
#else
    
    var attributes: [String:AnyObject] {
        return [:] // for now we don't do color logging except on macOS/OSX
    }
    
#endif

}
