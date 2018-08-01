extension Request {

    public class func putLoraDeviceTags(
        tags: [TagUpdateRequest], 
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putLoraDeviceTags(tags: tags, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putLoraDeviceTags()) is not sufficient):

        return req
    }
}