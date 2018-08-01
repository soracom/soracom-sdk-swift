extension Request {

    public class func listGatewaysInLoraNetworkSet(
        
        nsId: String,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraGateway]>? = nil
    ) ->   Request<[LoraGateway]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listGatewaysInLoraNetworkSet(nsId: nsId, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listGatewaysInLoraNetworkSet()) is not sufficient):

        return req
    }
}