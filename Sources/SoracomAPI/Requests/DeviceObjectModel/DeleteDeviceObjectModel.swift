extension Request {

    public class func deleteDeviceObjectModel(
        
        modelId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteDeviceObjectModel(modelId: modelId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteDeviceObjectModel()) is not sufficient):

        return req
    }
}