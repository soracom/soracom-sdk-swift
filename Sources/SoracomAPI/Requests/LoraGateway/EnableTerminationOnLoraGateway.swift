extension Request {

    public class func enableTerminationOnLoraGateway(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _enableTerminationOnLoraGateway(gatewayId: gatewayId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_enableTerminationOnLoraGateway()) is not sufficient):

        return req
    }
}