extension Request {

    public class func deleteSubscriberSession(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteSubscriberSession(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteSubscriberSession()) is not sufficient):

        return req
    }
}