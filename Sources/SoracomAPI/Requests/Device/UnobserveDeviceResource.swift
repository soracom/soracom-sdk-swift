extension Request {

    public class func unobserveDeviceResource(
        
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unobserveDeviceResource(deviceId: deviceId, object: object, instance: instance, resource: resource,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unobserveDeviceResource()) is not sufficient):

        return req
    }
}