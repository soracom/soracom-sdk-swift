extension Request {

    public class func listLagoonUsers(
        
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listLagoonUsers( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listLagoonUsers()) is not sufficient):

        return req
    }
}