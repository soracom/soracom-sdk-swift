extension Request where T == NoResponseBody {

    public class func issuePasswordResetToken(
        email: IssuePasswordResetTokenRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _issuePasswordResetToken(email: email,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_issuePasswordResetToken()) is not sufficient):

        return req
    }
}
