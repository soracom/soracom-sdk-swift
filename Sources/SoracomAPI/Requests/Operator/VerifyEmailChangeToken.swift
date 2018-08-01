extension Request {

    public class func verifyEmailChangeToken(
        token: VerifyEmailChangeTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifyEmailChangeToken(token: token,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifyEmailChangeToken()) is not sufficient):

        return req
    }
}