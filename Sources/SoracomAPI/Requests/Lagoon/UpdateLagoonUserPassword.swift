extension Request {

    public class func updateLagoonUserPassword(
        request: LagoonUserPasswordUpdatingRequest, 
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateLagoonUserPassword(request: request, lagoonUserId: lagoonUserId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateLagoonUserPassword()) is not sufficient):

        return req
    }
}