extension Request {

    public class func deleteLoraDeviceTag(
        
        deviceId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteLoraDeviceTag(deviceId: deviceId, tagName: tagName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteLoraDeviceTag()) is not sufficient):

        return req
    }
}