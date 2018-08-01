extension Request {

    public class func initializeOperator(
        request: InitRequest, 
        responseHandler: ResponseHandler<AuthResponse>? = nil
    ) ->   Request<AuthResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _initializeOperator(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_initializeOperator()) is not sufficient):

        return req
    }
}