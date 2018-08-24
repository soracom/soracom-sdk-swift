//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Verifies the password reset token and updates password.

        Updates the operator's password if the password reset token is verified.

        Docs: https://dev.soracom.io/en/docs/api/#!/Auth/verifyPasswordResetToken
    */
    public class func verifyPasswordResetToken(
        request: VerifyPasswordResetTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/auth/password_reset_token/verify"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post
        requestObject.shouldSendAPIKeyAndTokenInHTTPHeaders = false


        return requestObject
    }

}