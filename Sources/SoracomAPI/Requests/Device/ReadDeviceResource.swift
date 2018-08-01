extension Request {

    public class func readDeviceResource(
        
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<ResourceInstance>? = nil
    ) ->   Request<ResourceInstance> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _readDeviceResource(deviceId: deviceId, object: object, instance: instance, resource: resource, model: model,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_readDeviceResource()) is not sufficient):

        return req
    }
}