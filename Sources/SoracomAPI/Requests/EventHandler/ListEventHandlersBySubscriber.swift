extension Request {

    public class func listEventHandlersBySubscriber(
        
        imsi: String,
        responseHandler: ResponseHandler<[EventHandlerModel]>? = nil
    ) ->   Request<[EventHandlerModel]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listEventHandlersBySubscriber(imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listEventHandlersBySubscriber()) is not sufficient):

        return req
    }
}