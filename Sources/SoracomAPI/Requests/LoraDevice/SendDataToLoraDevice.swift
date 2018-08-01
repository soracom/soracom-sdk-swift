extension Request {

    public class func sendDataToLoraDevice(
        data: LoraData, 
        deviceId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _sendDataToLoraDevice(data: data, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_sendDataToLoraDevice()) is not sufficient):

        return req
    }
}