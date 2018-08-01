extension Request {

    public class func registerGatePeer(
        gatePeer: RegisterGatePeerRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<GatePeer>? = nil
    ) ->   Request<GatePeer> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerGatePeer(gatePeer: gatePeer, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerGatePeer()) is not sufficient):

        return req
    }
}