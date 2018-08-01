extension Request {

    public class func updateMirroringPeer(
        updates: [AttributeUpdate], 
        vpgId: String,
        ipaddr: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateMirroringPeer(updates: updates, vpgId: vpgId, ipaddr: ipaddr,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateMirroringPeer()) is not sufficient):

        return req
    }
}