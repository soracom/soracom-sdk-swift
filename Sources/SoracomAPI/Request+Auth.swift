// Request+Auth.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request where T == AuthResponse {
    
    /**
     Authenticate using one of the supported forms of credentials, and obtain an API Key and API Token for use when making subsequent requests. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth))
     
     - parameter credentials: A credentials object that can (optionally) override the default credentials. Unlike most API requests, which send the API Key and API Token in HTTP headers to authenticate, the `auth()` method requires authenticating with `.RootAccount`, `.SAM`, or `.AuthKey` credentials.
     
     If no credentials are supplied, the "default" credentials, if they exist, are used. If no credentials are supplied and none can be found, the request will fail.
     
     Upon success, the response will contain an AuthResponse struct, with the API Key and API Token.
     */
    public class func auth(_ credentials: SoracomCredentials? = nil, responseHandler: ResponseHandler<AuthResponse>? = nil) -> Request<AuthResponse> {
        
        let req = Request<AuthResponse>.init("/auth", responseHandler: responseHandler)
        let timeout = 86400
        
        req.credentials = credentials ?? SoracomCredentials.defaultSavedCredentials()
        
        guard let requestObject = AuthRequest(from: req.credentials) else {
            fatalError("unsupported auth type other than RootAccount, SAM, or AuthKey. ")
            // FIXME: fatalError is a little extreme bro... just make the request error.
        }
        
        requestObject.tokenTimeoutSeconds = timeout
        
        return auth(auth: requestObject, responseHandler: responseHandler)
    }
    
}


extension Request where T == NoResponseBody {
    
    /**
     Issues a password reset token for the operatosr.
     
     Generates a password reset token and send it to the operator's mail address. After receiving the password reset token, call /v1/auth/password_reset_token/verify API with the token to update operator's password.
     
     Docs: https://dev.soracom.io/en/docs/api/#!/Auth/issuePasswordResetToken
     */
    public class func issuePasswordResetToken(
        email: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) -> Request<NoResponseBody> {
        
        let requestObject = IssuePasswordResetTokenRequest(email: email)
        return issuePasswordResetToken(email: requestObject, responseHandler: responseHandler)
    }

    
    
    public class func verifyPasswordResetToken(_ password: String, token: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        return verifyPasswordResetToken(
            request: VerifyPasswordResetTokenRequest(password: password, token: token),
            responseHandler: responseHandler
        )
    }

}
