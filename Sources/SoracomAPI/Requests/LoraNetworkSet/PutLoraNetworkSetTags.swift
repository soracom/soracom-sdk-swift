extension Request {

    public class func putLoraNetworkSetTags(
        tags: [TagUpdateRequest], 
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putLoraNetworkSetTags(tags: tags, nsId: nsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putLoraNetworkSetTags()) is not sufficient):

        return req
    }
}