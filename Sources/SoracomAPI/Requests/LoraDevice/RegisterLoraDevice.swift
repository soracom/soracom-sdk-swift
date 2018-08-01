extension Request {

    public class func registerLoraDevice(
        loraDevice: RegisterLoraDeviceRequest, 
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerLoraDevice(loraDevice: loraDevice, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerLoraDevice()) is not sufficient):

        return req
    }
}