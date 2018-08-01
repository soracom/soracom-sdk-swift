extension Request {

    public class func deleteLagoonUser(
        
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteLagoonUser(lagoonUserId: lagoonUserId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteLagoonUser()) is not sufficient):

        return req
    }
}