extension Request {

    public class func deleteIgnoreEventHandler(
        
        imsi: String,
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteIgnoreEventHandler(imsi: imsi, handlerId: handlerId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteIgnoreEventHandler()) is not sufficient):

        return req
    }
}