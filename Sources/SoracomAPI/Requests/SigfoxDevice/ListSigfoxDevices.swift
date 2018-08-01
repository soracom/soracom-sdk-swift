extension Request {

    public class func listSigfoxDevices(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[SigfoxDevice]>? = nil
    ) ->   Request<[SigfoxDevice]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listSigfoxDevices(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listSigfoxDevices()) is not sufficient):

        return req
    }
}