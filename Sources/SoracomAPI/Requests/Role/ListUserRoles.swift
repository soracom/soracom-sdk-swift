extension Request {

    public class func listUserRoles(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<[RoleResponse]>? = nil
    ) ->   Request<[RoleResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listUserRoles(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listUserRoles()) is not sufficient):

        return req
    }
}