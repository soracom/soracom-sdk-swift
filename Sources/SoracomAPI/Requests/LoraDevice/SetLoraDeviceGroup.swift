extension Request {

    public class func setLoraDeviceGroup(
        group: Group, 
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setLoraDeviceGroup(group: group, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setLoraDeviceGroup()) is not sufficient):

        return req
    }
}