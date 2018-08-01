extension Request {

    public class func listDevices(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: String? = nil,
        lastEvaluatedKey: String? = nil,
        limit: Int? = nil,
        responseHandler: ResponseHandler<[Device]>? = nil
    ) ->   Request<[Device]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listDevices(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, lastEvaluatedKey: lastEvaluatedKey, limit: limit,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listDevices()) is not sufficient):

        return req
    }
}