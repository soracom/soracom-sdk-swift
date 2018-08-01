extension Request {

    public class func createEventHandler(
        req: CreateEventHandlerRequest, 
        responseHandler: ResponseHandler<EventHandlerModel>? = nil
    ) ->   Request<EventHandlerModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createEventHandler(req: req,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createEventHandler()) is not sufficient):

        return req
    }
}