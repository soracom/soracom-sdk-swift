extension Request {

    public class func deleteEventHandler(
        
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteEventHandler(handlerId: handlerId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteEventHandler()) is not sufficient):

        return req
    }
}