extension Request {

    public class func generateOperatorAuthKey(
        
        operatorId: String,
        responseHandler: ResponseHandler<GenerateOperatorsAuthKeyResponse>? = nil
    ) ->   Request<GenerateOperatorsAuthKeyResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _generateOperatorAuthKey(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_generateOperatorAuthKey()) is not sufficient):

        return req
    }
}