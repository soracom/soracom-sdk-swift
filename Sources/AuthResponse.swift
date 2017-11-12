// AuthResponse.swift Created by mason on 2017-07-18. Copyright © 2017 Soracom, Inc. All rights reserved.

/// This is the object included in the response returned by the API auth() call. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/auth)

public struct AuthResponse: PayloadConvertible, Codable {
    
    var apiKey: String
    var token: String
    var operatorId: String? = nil
    var userName: String?   = nil
    
    public init(apiKey: String, token: String, operatorId: String? = nil, userName: String? = nil) {
        
        self.apiKey     = apiKey
        self.token      = token
        self.operatorId = operatorId
        self.userName   = userName
    }
}

enum AuthResponseValidationError: Error {
    case missingApiKeyOrTokenInServerResponse
}
