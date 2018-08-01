extension Request {

    public class func readDeviceResources(
        
        deviceId: String,
        object: String,
        instance: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<ObjectInstance>? = nil
    ) ->   Request<ObjectInstance> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _readDeviceResources(deviceId: deviceId, object: object, instance: instance, model: model,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_readDeviceResources()) is not sufficient):

        return req
    }
}