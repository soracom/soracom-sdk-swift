extension Request {

    public class func verifySubscriberTransferToken(
        token: VerifySubscriberTransferTokenRequest, 
        responseHandler: ResponseHandler<VerifySubscriberTransferTokenResponse>? = nil
    ) ->   Request<VerifySubscriberTransferTokenResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifySubscriberTransferToken(token: token,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifySubscriberTransferToken()) is not sufficient):

        return req
    }
}