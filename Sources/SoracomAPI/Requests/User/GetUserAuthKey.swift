extension Request {

    public class func getUserAuthKey(
        
        operatorId: String,
        userName: String,
        authKeyId: String,
        responseHandler: ResponseHandler<AuthKeyResponse>? = nil
    ) ->   Request<AuthKeyResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getUserAuthKey(operatorId: operatorId, userName: userName, authKeyId: authKeyId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getUserAuthKey()) is not sufficient):

        return req
    }
}