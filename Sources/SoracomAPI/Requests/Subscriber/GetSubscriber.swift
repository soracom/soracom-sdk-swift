extension Request {

    public class func getSubscriber(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getSubscriber(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getSubscriber()) is not sufficient):

        return req
    }
}