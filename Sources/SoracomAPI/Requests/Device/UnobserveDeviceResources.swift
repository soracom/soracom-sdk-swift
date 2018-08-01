extension Request {

    public class func unobserveDeviceResources(
        
        deviceId: String,
        object: String,
        instance: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unobserveDeviceResources(deviceId: deviceId, object: object, instance: instance,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unobserveDeviceResources()) is not sufficient):

        return req
    }
}