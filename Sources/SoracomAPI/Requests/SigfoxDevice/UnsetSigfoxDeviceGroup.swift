extension Request {

    public class func unsetSigfoxDeviceGroup(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetSigfoxDeviceGroup(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetSigfoxDeviceGroup()) is not sufficient):

        return req
    }
}