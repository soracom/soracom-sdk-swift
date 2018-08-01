extension Request {

    public class func getSigfoxDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getSigfoxDevice(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getSigfoxDevice()) is not sufficient):

        return req
    }
}