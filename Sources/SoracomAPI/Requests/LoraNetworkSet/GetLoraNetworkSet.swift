extension Request {

    public class func getLoraNetworkSet(
        
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getLoraNetworkSet(nsId: nsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getLoraNetworkSet()) is not sufficient):

        return req
    }
}