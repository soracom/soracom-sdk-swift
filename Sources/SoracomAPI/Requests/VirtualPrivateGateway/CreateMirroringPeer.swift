extension Request {

    public class func createMirroringPeer(
        mirroringPeer: JunctionMirroringPeer, 
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createMirroringPeer(mirroringPeer: mirroringPeer, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createMirroringPeer()) is not sufficient):

        return req
    }
}