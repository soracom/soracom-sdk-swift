extension Request where T == NoResponseBody {
    
    /// Issue a one-time operator password reset token (sent via email). [API docs](https://dev.soracom.io/jp/docs/api/#!/Auth/issuePasswordResetToken)
    
    public class func issuePasswordResetToken(
        email: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
        ) ->   Request<NoResponseBody> {
        
        let requestObject = IssuePasswordResetTokenRequest(email: email)
        return issuePasswordResetToken(email: requestObject, responseHandler: responseHandler)
    }
    
}
