extension Request {

    public class func updateLagoonUserEmail(
        request: LagoonUserEmailUpdatingRequest, 
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateLagoonUserEmail(request: request, lagoonUserId: lagoonUserId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateLagoonUserEmail()) is not sufficient):

        return req
    }
}