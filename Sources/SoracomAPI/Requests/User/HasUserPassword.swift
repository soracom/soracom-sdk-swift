extension Request {

    public class func hasUserPassword(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GetUserPasswordResponse>? = nil
    ) ->   Request<GetUserPasswordResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _hasUserPassword(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_hasUserPassword()) is not sufficient):

        return req
    }
}