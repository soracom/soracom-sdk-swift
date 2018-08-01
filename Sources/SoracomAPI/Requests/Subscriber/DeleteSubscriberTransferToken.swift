extension Request {

    public class func deleteSubscriberTransferToken(
        
        token: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteSubscriberTransferToken(token: token,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteSubscriberTransferToken()) is not sufficient):

        return req
    }
}