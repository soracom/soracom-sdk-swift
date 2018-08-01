extension Request {

    public class func unsetRedirectionConfiguration(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetRedirectionConfiguration(vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetRedirectionConfiguration()) is not sufficient):

        return req
    }
}