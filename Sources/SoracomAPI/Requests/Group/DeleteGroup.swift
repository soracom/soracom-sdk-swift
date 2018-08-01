extension Request {

    public class func deleteGroup(
        
        groupId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteGroup(groupId: groupId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteGroup()) is not sufficient):

        return req
    }
}