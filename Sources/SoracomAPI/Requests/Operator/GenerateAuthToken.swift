extension Request {

    public class func generateAuthToken(
        request: GenerateTokenRequest, 
        operatorId: String,
        responseHandler: ResponseHandler<GenerateTokenResponse>? = nil
    ) ->   Request<GenerateTokenResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _generateAuthToken(request: request, operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_generateAuthToken()) is not sufficient):

        return req
    }
}