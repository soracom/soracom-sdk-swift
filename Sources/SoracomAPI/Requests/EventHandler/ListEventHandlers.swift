extension Request {

    public class func listEventHandlers(
        
        target: Target? = nil,
        responseHandler: ResponseHandler<[EventHandlerModel]>? = nil
    ) ->   Request<[EventHandlerModel]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listEventHandlers(target: target,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listEventHandlers()) is not sufficient):

        return req
    }
}