extension Request {

    public class func getUser(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<UserDetailResponse>? = nil
    ) ->   Request<UserDetailResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getUser(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getUser()) is not sufficient):

        return req
    }
}