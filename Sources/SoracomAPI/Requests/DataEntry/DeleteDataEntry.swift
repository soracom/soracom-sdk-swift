extension Request {

    public class func deleteDataEntry(
        
        resourceType: ResourceType,
        resourceId: String,
        time: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteDataEntry(resourceType: resourceType, resourceId: resourceId, time: time,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteDataEntry()) is not sufficient):

        return req
    }
}