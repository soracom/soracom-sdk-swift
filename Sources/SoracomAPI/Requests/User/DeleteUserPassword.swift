extension Request {

    public class func deleteUserPassword(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteUserPassword(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteUserPassword()) is not sufficient):

        return req
    }
}