extension Request {

    public class func terminateLagoon(
        
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _terminateLagoon( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_terminateLagoon()) is not sufficient):

        return req
    }
}