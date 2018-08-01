extension Request {

    public class func createRole(
        request: CreateOrUpdateRoleRequest, 
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<CreateRoleResponse>? = nil
    ) ->   Request<CreateRoleResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createRole(request: request, operatorId: operatorId, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createRole()) is not sufficient):

        return req
    }
}