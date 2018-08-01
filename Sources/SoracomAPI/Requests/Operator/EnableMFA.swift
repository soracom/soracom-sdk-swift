extension Request {

    public class func enableMFA(
        
        operatorId: String,
        responseHandler: ResponseHandler<EnableMFAOTPResponse>? = nil
    ) ->   Request<EnableMFAOTPResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _enableMFA(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_enableMFA()) is not sufficient):

        return req
    }
}