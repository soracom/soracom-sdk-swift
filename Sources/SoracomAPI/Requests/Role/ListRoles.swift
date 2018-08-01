extension Request {

    public class func listRoles(
        
        operatorId: String,
        responseHandler: ResponseHandler<[ListRolesResponse]>? = nil
    ) ->   Request<[ListRolesResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listRoles(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listRoles()) is not sufficient):

        return req
    }
}