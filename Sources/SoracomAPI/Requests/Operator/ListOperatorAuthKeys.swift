extension Request {

    public class func listOperatorAuthKeys(
        
        operatorId: String,
        responseHandler: ResponseHandler<[AuthKeyResponse]>? = nil
    ) ->   Request<[AuthKeyResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listOperatorAuthKeys(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listOperatorAuthKeys()) is not sufficient):

        return req
    }
}