extension Request {

    public class func deleteOperatorAuthKey(
        
        operatorId: String,
        authKeyId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteOperatorAuthKey(operatorId: operatorId, authKeyId: authKeyId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteOperatorAuthKey()) is not sufficient):

        return req
    }
}