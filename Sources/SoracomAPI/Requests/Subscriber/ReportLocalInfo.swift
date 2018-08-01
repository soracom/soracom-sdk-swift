extension Request {

    public class func reportLocalInfo(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _reportLocalInfo(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_reportLocalInfo()) is not sufficient):

        return req
    }
}