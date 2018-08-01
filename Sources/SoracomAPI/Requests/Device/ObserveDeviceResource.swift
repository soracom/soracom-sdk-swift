extension Request {

    public class func observeDeviceResource(
        
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _observeDeviceResource(deviceId: deviceId, object: object, instance: instance, resource: resource, model: model,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_observeDeviceResource()) is not sufficient):

        return req
    }
}