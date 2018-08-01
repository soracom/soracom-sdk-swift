extension Request {

    public class func createLagoonUser(
        request: LagoonUserCreationRequest, 
        responseHandler: ResponseHandler<LagoonUserCreationResponse>? = nil
    ) ->   Request<LagoonUserCreationResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createLagoonUser(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createLagoonUser()) is not sufficient):

        return req
    }
}