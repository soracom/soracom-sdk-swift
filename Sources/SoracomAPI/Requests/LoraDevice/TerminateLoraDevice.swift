extension Request {

    public class func terminateLoraDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _terminateLoraDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_terminateLoraDevice()) is not sufficient):

        return req
    }
}