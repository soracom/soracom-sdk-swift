extension Request {

    public class func openGate(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _openGate(vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_openGate()) is not sufficient):

        return req
    }
}