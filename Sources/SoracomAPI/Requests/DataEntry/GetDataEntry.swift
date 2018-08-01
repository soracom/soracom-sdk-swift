extension Request {

    public class func getDataEntry(
        
        resourceType: ResourceType,
        resourceId: String,
        time: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getDataEntry(resourceType: resourceType, resourceId: resourceId, time: time,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getDataEntry()) is not sufficient):

        return req
    }
}