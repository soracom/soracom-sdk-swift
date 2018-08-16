// AuthRequest.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

extension AuthRequest {

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
}
