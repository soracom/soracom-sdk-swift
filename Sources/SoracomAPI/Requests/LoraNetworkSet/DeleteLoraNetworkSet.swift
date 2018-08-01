extension Request {

    public class func deleteLoraNetworkSet(
        
        nsId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteLoraNetworkSet(nsId: nsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteLoraNetworkSet()) is not sufficient):

        return req
    }
}