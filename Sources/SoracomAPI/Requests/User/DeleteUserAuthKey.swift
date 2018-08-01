extension Request {

    public class func deleteUserAuthKey(
        
        operatorId: String,
        userName: String,
        authKeyId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteUserAuthKey(operatorId: operatorId, userName: userName, authKeyId: authKeyId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteUserAuthKey()) is not sufficient):

        return req
    }
}