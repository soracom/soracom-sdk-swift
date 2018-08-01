extension Request {

    public class func updateUserPassword(
        request: UpdatePasswordRequest, 
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateUserPassword(request: request, operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateUserPassword()) is not sufficient):

        return req
    }
}