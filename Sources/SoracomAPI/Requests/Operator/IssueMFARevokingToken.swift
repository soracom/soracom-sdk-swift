extension Request {

    public class func issueMFARevokingToken(
        request: MFAIssueRevokingTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _issueMFARevokingToken(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_issueMFARevokingToken()) is not sufficient):

        return req
    }
}