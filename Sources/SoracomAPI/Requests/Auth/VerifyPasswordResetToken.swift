extension Request where T == NoResponseBody {

    /// Verify an operator password reset token. [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/verifyPasswordResetToken)

    public class func verifyPasswordResetToken(
        request: VerifyPasswordResetTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifyPasswordResetToken(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifyPasswordResetToken()) is not sufficient):

        return req
    }
    
}
