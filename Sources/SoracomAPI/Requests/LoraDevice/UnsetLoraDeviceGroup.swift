extension Request {

    public class func unsetLoraDeviceGroup(
        
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetLoraDeviceGroup(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetLoraDeviceGroup()) is not sufficient):

        return req
    }
}