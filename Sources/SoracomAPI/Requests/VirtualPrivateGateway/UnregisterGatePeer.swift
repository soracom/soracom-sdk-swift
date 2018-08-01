extension Request {

    public class func unregisterGatePeer(
        
        vpgId: String,
        outerIpAddress: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unregisterGatePeer(vpgId: vpgId, outerIpAddress: outerIpAddress,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unregisterGatePeer()) is not sufficient):

        return req
    }
}