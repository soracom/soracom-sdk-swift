extension Request {

    public class func issueEmailChangeToken(
        request: IssueEmailChangeTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _issueEmailChangeToken(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_issueEmailChangeToken()) is not sufficient):

        return req
    }
}