// AuthRequest.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

public class AuthRequest: _AuthRequest {

    convenience init?(from credentials: SoracomCredentials) {
        self.init()
        switch credentials.type {
        case .RootAccount:
            email = credentials.emailAddress
            password = credentials.password
        case .SAM:
            operatorId = credentials.operatorID
            userName = credentials.username
            password = credentials.password
        case .AuthKey:
            authKey = credentials.authKeySecret
            authKeyId = credentials.authKeyID
        case .KeyAndToken:
            return nil
        }
    }
    
    // The base implementation for this class is provided by the
    // auto-generated superclass (_AuthRequest).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}
