extension Request {

    public class func registerLagoon(
        request: LagoonRegistrationRequest, 
        responseHandler: ResponseHandler<LagoonRegistrationResponse>? = nil
    ) ->   Request<LagoonRegistrationResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerLagoon(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerLagoon()) is not sufficient):

        return req
    }
}