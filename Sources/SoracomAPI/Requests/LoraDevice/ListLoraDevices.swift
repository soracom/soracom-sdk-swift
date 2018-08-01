extension Request {

    public class func listLoraDevices(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraDevice]>? = nil
    ) ->   Request<[LoraDevice]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listLoraDevices(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listLoraDevices()) is not sufficient):

        return req
    }
}