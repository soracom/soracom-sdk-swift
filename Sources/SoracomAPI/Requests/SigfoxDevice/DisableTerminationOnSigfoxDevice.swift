extension Request {

    public class func disableTerminationOnSigfoxDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _disableTerminationOnSigfoxDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_disableTerminationOnSigfoxDevice()) is not sufficient):

        return req
    }
}