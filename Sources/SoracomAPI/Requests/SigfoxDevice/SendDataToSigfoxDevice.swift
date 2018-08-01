extension Request {

    public class func sendDataToSigfoxDevice(
        data: SigfoxData, 
        deviceId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _sendDataToSigfoxDevice(data: data, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_sendDataToSigfoxDevice()) is not sufficient):

        return req
    }
}