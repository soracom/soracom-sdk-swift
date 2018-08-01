extension Request {

    public class func setIgnoreEventHandler(
        
        imsi: String,
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setIgnoreEventHandler(imsi: imsi, handlerId: handlerId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setIgnoreEventHandler()) is not sufficient):

        return req
    }
}