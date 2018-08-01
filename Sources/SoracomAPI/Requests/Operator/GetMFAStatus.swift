extension Request {

    public class func getMFAStatus(
        
        operatorId: String,
        responseHandler: ResponseHandler<MFAStatusOfUseResponse>? = nil
    ) ->   Request<MFAStatusOfUseResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getMFAStatus(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getMFAStatus()) is not sufficient):

        return req
    }
}