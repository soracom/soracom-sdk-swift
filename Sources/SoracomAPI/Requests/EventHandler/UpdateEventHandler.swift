extension Request {

    public class func updateEventHandler(
        eventHandlerModel: UpdateEventHandlerRequest, 
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateEventHandler(eventHandlerModel: eventHandlerModel, handlerId: handlerId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateEventHandler()) is not sufficient):

        return req
    }
}