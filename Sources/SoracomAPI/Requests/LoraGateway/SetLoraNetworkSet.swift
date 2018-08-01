extension Request {

    public class func setLoraNetworkSet(
        nsId: SetNetworkSetRequest, 
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setLoraNetworkSet(nsId: nsId, gatewayId: gatewayId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setLoraNetworkSet()) is not sufficient):

        return req
    }
}