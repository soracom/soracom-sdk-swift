extension Request {

    public class func terminateSigfoxDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _terminateSigfoxDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_terminateSigfoxDevice()) is not sufficient):

        return req
    }
}