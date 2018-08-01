extension Request {

    public class func createVpcPeeringConnection(
        vpcPeeringConnection: CreateVpcPeeringConnectionRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<CreateVpcPeeringConnectionRequest>? = nil
    ) ->   Request<CreateVpcPeeringConnectionRequest> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createVpcPeeringConnection(vpcPeeringConnection: vpcPeeringConnection, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createVpcPeeringConnection()) is not sufficient):

        return req
    }
}