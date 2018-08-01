extension Request {

    public class func createVirtualPrivateGateway(
        createVirtualPrivateGatewayRequest: CreateVirtualPrivateGatewayRequest, 
        responseHandler: ResponseHandler<VirtualPrivateGateway>? = nil
    ) ->   Request<VirtualPrivateGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createVirtualPrivateGateway(createVirtualPrivateGatewayRequest: createVirtualPrivateGatewayRequest,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createVirtualPrivateGateway()) is not sufficient):

        return req
    }
}