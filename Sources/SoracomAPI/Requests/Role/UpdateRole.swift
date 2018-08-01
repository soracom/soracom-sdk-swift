extension Request {

    public class func updateRole(
        request: CreateOrUpdateRoleRequest, 
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateRole(request: request, operatorId: operatorId, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateRole()) is not sufficient):

        return req
    }
}