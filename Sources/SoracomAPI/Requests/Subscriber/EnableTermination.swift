extension Request {

    public class func enableTermination(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _enableTermination(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_enableTermination()) is not sufficient):

        return req
    }
}