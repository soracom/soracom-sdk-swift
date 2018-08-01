extension Request {

    public class func getDevice(
        
        deviceId: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getDevice(deviceId: deviceId, model: model,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getDevice()) is not sufficient):

        return req
    }
}