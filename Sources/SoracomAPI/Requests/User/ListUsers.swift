extension Request {

    public class func listUsers(
        
        operatorId: String,
        responseHandler: ResponseHandler<[UserDetailResponse]>? = nil
    ) ->   Request<[UserDetailResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listUsers(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listUsers()) is not sufficient):

        return req
    }
}