//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Issues a password reset token for the operator.

        Generates a password reset token and sends it to the operator's mail address. After receiving the password reset token, call /v1/auth/password_reset_token/verify API with the token to update operator's password.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Auth/issuePasswordResetToken)
    */
    public class func issuePasswordResetToken(
        email: IssuePasswordResetTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/auth/password_reset_token/issue"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = email.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post
        requestObject.shouldSendAPIKeyAndTokenInHTTPHeaders = false


        return requestObject
    }

}
