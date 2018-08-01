extension Request {

    public class func enableTerminationOnSigfoxDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _enableTerminationOnSigfoxDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_enableTerminationOnSigfoxDevice()) is not sufficient):

        return req
    }
}