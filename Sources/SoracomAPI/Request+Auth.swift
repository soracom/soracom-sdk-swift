// Request+Auth.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request {
    
    
    /// Issue a one-time operator password reset token (sent via email). [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/issuePasswordResetToken)
    
    public class func issuePasswordResetToken(_ email: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        let req = Request<NoResponseBody>.init("/auth/password_reset_token/issue", responseHandler: responseHandler)
        req.messageBody = IssuePasswordResetTokenRequest(email: email).toData()
        return req
    }
    
    
    /// Verify an operator password reset token. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/verifyPasswordResetToken)
    
    public class func verifyPasswordResetToken(_ password: String, token: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        let req = Request<NoResponseBody>.init("/auth/password_reset_token/verify", responseHandler: responseHandler)
        req.messageBody = VerifyPasswordResetTokenRequest(password: password, token: token).toData()
        return req
    }

}
