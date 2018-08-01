extension Request {

    public class func unsetInspectionConfiguration(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetInspectionConfiguration(vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetInspectionConfiguration()) is not sufficient):

        return req
    }
}