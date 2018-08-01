extension Request {

    public class func detachRole(
        
        operatorId: String,
        userName: String,
        roleId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _detachRole(operatorId: operatorId, userName: userName, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_detachRole()) is not sufficient):

        return req
    }
}