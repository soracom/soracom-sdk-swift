extension Request {

    public class func executeDeviceResource(
        arg: Arg, 
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _executeDeviceResource(arg: arg, deviceId: deviceId, object: object, instance: instance, resource: resource,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_executeDeviceResource()) is not sufficient):

        return req
    }
}