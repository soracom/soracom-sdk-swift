extension Request {

    public class func getUserPermission(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GetUserPermissionResponse>? = nil
    ) ->   Request<GetUserPermissionResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getUserPermission(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getUserPermission()) is not sufficient):

        return req
    }
}