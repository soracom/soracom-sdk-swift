extension Request {

    public class func listLoraNetworkSets(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraNetworkSet]>? = nil
    ) ->   Request<[LoraNetworkSet]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listLoraNetworkSets(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listLoraNetworkSets()) is not sufficient):

        return req
    }
}