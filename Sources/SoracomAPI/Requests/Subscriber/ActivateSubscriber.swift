extension Request {

    public class func activateSubscriber(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _activateSubscriber(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_activateSubscriber()) is not sufficient):

        return req
    }
}