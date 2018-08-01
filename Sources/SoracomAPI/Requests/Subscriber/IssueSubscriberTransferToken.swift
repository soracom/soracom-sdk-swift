extension Request {

    public class func issueSubscriberTransferToken(
        request: IssueSubscriberTransferTokenRequest, 
        responseHandler: ResponseHandler<IssueSubscriberTransferTokenResponse>? = nil
    ) ->   Request<IssueSubscriberTransferTokenResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _issueSubscriberTransferToken(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_issueSubscriberTransferToken()) is not sufficient):

        return req
    }
}