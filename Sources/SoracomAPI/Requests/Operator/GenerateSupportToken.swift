extension Request {

    public class func generateSupportToken(
        
        operatorId: String,
        responseHandler: ResponseHandler<SupportTokenResponse>? = nil
    ) ->   Request<SupportTokenResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _generateSupportToken(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_generateSupportToken()) is not sufficient):

        return req
    }
}