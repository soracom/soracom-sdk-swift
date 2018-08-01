extension Request {

    public class func unsetExpiryTime(
        
        imsi: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetExpiryTime(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetExpiryTime()) is not sufficient):

        return req
    }
}