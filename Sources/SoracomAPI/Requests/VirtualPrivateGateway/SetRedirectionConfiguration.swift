extension Request {

    public class func setRedirectionConfiguration(
        redirectionConfiguration: JunctionRedirectionConfiguration, 
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setRedirectionConfiguration(redirectionConfiguration: redirectionConfiguration, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setRedirectionConfiguration()) is not sufficient):

        return req
    }
}