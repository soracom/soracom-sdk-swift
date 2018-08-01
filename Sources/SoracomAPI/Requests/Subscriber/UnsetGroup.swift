extension Request {

    public class func unsetGroup(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetGroup(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetGroup()) is not sufficient):

        return req
    }
}