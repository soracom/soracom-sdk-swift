extension Request {

    public class func listLoraGateways(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraGateway]>? = nil
    ) ->   Request<[LoraGateway]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listLoraGateways(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listLoraGateways()) is not sufficient):

        return req
    }
}