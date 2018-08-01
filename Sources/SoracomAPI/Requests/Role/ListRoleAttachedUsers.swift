extension Request {

    public class func listRoleAttachedUsers(
        
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<[UserDetailResponse]>? = nil
    ) ->   Request<[UserDetailResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listRoleAttachedUsers(operatorId: operatorId, roleId: roleId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listRoleAttachedUsers()) is not sufficient):

        return req
    }
}