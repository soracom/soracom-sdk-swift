extension Request {

    public class func setSigfoxDeviceGroup(
        group: Group, 
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setSigfoxDeviceGroup(group: group, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setSigfoxDeviceGroup()) is not sufficient):

        return req
    }
}