extension Request {

    public class func deleteRole(
        
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteRole(operatorId: operatorId, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteRole()) is not sufficient):

        return req
    }
}