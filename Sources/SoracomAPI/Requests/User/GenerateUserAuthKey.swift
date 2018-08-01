extension Request {

    public class func generateUserAuthKey(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GenerateUserAuthKeyResponse>? = nil
    ) ->   Request<GenerateUserAuthKeyResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _generateUserAuthKey(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_generateUserAuthKey()) is not sufficient):

        return req
    }
}