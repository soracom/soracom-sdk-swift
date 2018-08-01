extension Request {

    public class func unsetLoraNetworkSet(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetLoraNetworkSet(gatewayId: gatewayId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetLoraNetworkSet()) is not sufficient):

        return req
    }
}