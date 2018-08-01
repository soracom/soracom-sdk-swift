extension Request {

    public class func deleteLoraNetworkSetTag(
        
        nsId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteLoraNetworkSetTag(nsId: nsId, tagName: tagName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteLoraNetworkSetTag()) is not sufficient):

        return req
    }
}