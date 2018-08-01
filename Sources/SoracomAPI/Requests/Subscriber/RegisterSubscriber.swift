extension Request {

    public class func registerSubscriber(
        subscriber: RegisterSubscribersRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerSubscriber(subscriber: subscriber, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerSubscriber()) is not sufficient):

        return req
    }
}