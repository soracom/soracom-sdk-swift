extension Request {

    public class func revokeMFA(
        
        operatorId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _revokeMFA(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_revokeMFA()) is not sufficient):

        return req
    }
}