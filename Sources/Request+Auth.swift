// Request+Auth.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request {
    
    /// Authenticate using one of the supported forms of credentials, and obtain an API Key and API Token for use when making subsequent requests. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth))
    ///
    /// - parameter credentials: A credentials object that can (optionally) override the default credentials. Unlike most
    ///   API requests, which send the API Key and API Token in HTTP headers to authenticate, the `auth()` method requires
    ///   authenticating with `.RootAccount`, `.SAM`, or `.AuthKey` credentials.
    ///
    ///   If no credentials are supplied, the "default" credentials, if they exist, are used. If no credentials are supplied
    ///   and none can be found, the request will fail.
    ///
    /// Upon success, the Response will have a payload that can be used to initialize an AuthResponse struct, that contains the API Key and API Token.
    
    public class func auth(credentials: SoracomCredentials? = nil, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/auth", responseHandler: responseHandler)
        let timeout = 86400
        
        req.credentials = credentials ?? SoracomCredentials(withStoredType: .RootAccount)
        
        if req.credentials.type == .RootAccount {
            
            req.requestPayload = [
                .email               : req.credentials.emailAddress,
                .password            : req.credentials.password,
                .tokenTimeoutSeconds : timeout
            ]
            
        } else if req.credentials.type == .SAM {
            
            req.requestPayload = [
                .operatorId          : req.credentials.operatorID,
                .userName            : req.credentials.username,
                .password            : req.credentials.password,
                .tokenTimeoutSeconds : timeout
            ]
            
        } else if req.credentials.type == .AuthKey {
            
            req.requestPayload = [
                .authKey             : req.credentials.authKeySecret,
                .authKeyId           : req.credentials.authKeyID,
                .tokenTimeoutSeconds : timeout
            ]
            
        } else {
            
            fatalError("unsupported auth type other than RootAccount, SAM, or AuthKey. ")
        }
        
        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false // is auth() the only false case?
        
        return req
    }
    
    
    /// Issue a one-time operator password reset token (sent via email_. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/issuePasswordResetToken)
    
    public class func issuePasswordResetToken(email: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/auth/password_reset_token/issue", responseHandler: responseHandler)
        req.requestPayload = [
            .email: email
        ]
        return req
    }
    
    
    /// Verify an operator password reset token. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/verifyPasswordResetToken)
    
    public class func verifyPasswordResetToken(password: String, token: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/auth/password_reset_token/verify", responseHandler: responseHandler)
        req.requestPayload = [
            .password : password,
            .token    : token,
        ]
        return req
    }

}
