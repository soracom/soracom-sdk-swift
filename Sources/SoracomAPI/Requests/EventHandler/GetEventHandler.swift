extension Request {

    public class func getEventHandler(
        
        handlerId: String,
        responseHandler: ResponseHandler<EventHandlerModel>? = nil
    ) ->   Request<EventHandlerModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getEventHandler(handlerId: handlerId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getEventHandler()) is not sufficient):

        return req
    }
}