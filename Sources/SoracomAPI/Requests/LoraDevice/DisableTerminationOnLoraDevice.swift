extension Request {

    public class func disableTerminationOnLoraDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _disableTerminationOnLoraDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_disableTerminationOnLoraDevice()) is not sufficient):

        return req
    }
}