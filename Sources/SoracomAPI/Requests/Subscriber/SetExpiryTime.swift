extension Request {

    public class func setExpiryTime(
        request: ExpiryTime, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setExpiryTime(request: request, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setExpiryTime()) is not sufficient):

        return req
    }
}