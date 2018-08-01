extension Request {

    public class func createDeviceObjectModel(
        objectModelDefinition: DeviceObjectModel, 
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createDeviceObjectModel(objectModelDefinition: objectModelDefinition,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createDeviceObjectModel()) is not sufficient):

        return req
    }
}