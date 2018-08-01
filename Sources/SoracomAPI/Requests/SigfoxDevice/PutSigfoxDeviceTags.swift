extension Request {

    public class func putSigfoxDeviceTags(
        tags: [TagUpdateRequest], 
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putSigfoxDeviceTags(tags: tags, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putSigfoxDeviceTags()) is not sufficient):

        return req
    }
}