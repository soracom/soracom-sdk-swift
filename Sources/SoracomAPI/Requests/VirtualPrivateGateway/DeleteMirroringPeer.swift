extension Request {

    public class func deleteMirroringPeer(
        
        vpgId: String,
        ipaddr: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteMirroringPeer(vpgId: vpgId, ipaddr: ipaddr,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteMirroringPeer()) is not sufficient):

        return req
    }
}