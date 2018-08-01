extension Request {

    public class func listUserAuthKeys(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<[AuthKeyResponse]>? = nil
    ) ->   Request<[AuthKeyResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listUserAuthKeys(operatorId: operatorId, userName: userName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listUserAuthKeys()) is not sufficient):

        return req
    }
}