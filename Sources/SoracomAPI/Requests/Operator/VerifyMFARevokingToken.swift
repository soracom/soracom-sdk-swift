extension Request {

    public class func verifyMFARevokingToken(
        request: MFARevokingTokenVerifyRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifyMFARevokingToken(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifyMFARevokingToken()) is not sufficient):

        return req
    }
}