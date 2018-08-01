extension Request {

    public class func updateDeviceObjectModel(
        objectModelDefinition: DeviceObjectModel, 
        modelId: String,
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateDeviceObjectModel(objectModelDefinition: objectModelDefinition, modelId: modelId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateDeviceObjectModel()) is not sufficient):

        return req
    }
}