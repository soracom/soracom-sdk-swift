extension Request {

    public class func revokePermissionFromLoraNetworkSet(
        operatorId: UpdatePermissionRequest, 
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _revokePermissionFromLoraNetworkSet(operatorId: operatorId, nsId: nsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_revokePermissionFromLoraNetworkSet()) is not sufficient):

        return req
    }
}