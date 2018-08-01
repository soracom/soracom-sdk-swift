extension Request {

    public class func deleteVpcPeeringConnection(
        
        vpgId: String,
        pcxId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteVpcPeeringConnection(vpgId: vpgId, pcxId: pcxId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteVpcPeeringConnection()) is not sufficient):

        return req
    }
}