extension Request {

    public class func updateLagoonUserPermission(
        request: LagoonUserPermissionUpdatingRequest, 
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateLagoonUserPermission(request: request, lagoonUserId: lagoonUserId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateLagoonUserPermission()) is not sufficient):

        return req
    }
}