extension Request {

    public class func getRole(
        
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<RoleResponse>? = nil
    ) ->   Request<RoleResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getRole(operatorId: operatorId, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getRole()) is not sufficient):

        return req
    }
}