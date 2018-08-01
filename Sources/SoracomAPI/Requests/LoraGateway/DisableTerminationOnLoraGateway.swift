extension Request {

    public class func disableTerminationOnLoraGateway(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _disableTerminationOnLoraGateway(gatewayId: gatewayId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_disableTerminationOnLoraGateway()) is not sufficient):

        return req
    }
}