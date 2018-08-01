extension Request {

    public class func getLoraDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getLoraDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getLoraDevice()) is not sufficient):

        return req
    }
}