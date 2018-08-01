extension Request {

    public class func updateOperatorPassword(
        request: UpdatePasswordRequest, 
        operatorId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateOperatorPassword(request: request, operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateOperatorPassword()) is not sufficient):

        return req
    }
}