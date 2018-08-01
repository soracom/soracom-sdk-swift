extension Request {

    public class func getDeviceObjectModel(
        
        modelId: String,
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getDeviceObjectModel(modelId: modelId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getDeviceObjectModel()) is not sufficient):

        return req
    }
}