extension Request {

    public class func verifyMFA(
        request: MFAAuthenticationRequest, 
        operatorId: String,
        responseHandler: ResponseHandler<OperatorMFAVerifyingResponse>? = nil
    ) ->   Request<OperatorMFAVerifyingResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifyMFA(request: request, operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifyMFA()) is not sufficient):

        return req
    }
}