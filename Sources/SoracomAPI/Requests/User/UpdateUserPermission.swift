extension Request {

    public class func updateUserPermission(
        request: SetUserPermissionRequest, 
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateUserPermission(request: request, operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateUserPermission()) is not sufficient):

        return req
    }
}