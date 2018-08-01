extension Request {

    public class func listVirtualPrivateGateways(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[VirtualPrivateGateway]>? = nil
    ) ->   Request<[VirtualPrivateGateway]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listVirtualPrivateGateways(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listVirtualPrivateGateways()) is not sufficient):

        return req
    }
}