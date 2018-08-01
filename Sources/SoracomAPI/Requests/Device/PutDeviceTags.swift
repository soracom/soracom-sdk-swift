extension Request {

    public class func putDeviceTags(
        
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putDeviceTags(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putDeviceTags()) is not sufficient):

        return req
    }
}