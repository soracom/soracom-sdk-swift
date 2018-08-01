extension Request {

    public class func createLoraNetworkSet(
        loraNetworkSet: LoraNetworkSet, 
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createLoraNetworkSet(loraNetworkSet: loraNetworkSet,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createLoraNetworkSet()) is not sufficient):

        return req
    }
}