extension Request {

    public class func listGatePeers(
        
        vpgId: String,
        responseHandler: ResponseHandler<[GatePeer]>? = nil
    ) ->   Request<[GatePeer]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listGatePeers(vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listGatePeers()) is not sufficient):

        return req
    }
}