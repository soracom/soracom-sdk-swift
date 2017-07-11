// Data+SoracomSDK.swift Created by mason on 2017-07-11. Copyright © 2017 Soracom, Inc. All rights reserved.

import Foundation

extension Data {
    
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
}
