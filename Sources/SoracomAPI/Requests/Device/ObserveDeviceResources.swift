extension Request {

    public class func observeDeviceResources(
        
        deviceId: String,
        object: String,
        instance: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _observeDeviceResources(deviceId: deviceId, object: object, instance: instance, model: model,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_observeDeviceResources()) is not sufficient):

        return req
    }
}