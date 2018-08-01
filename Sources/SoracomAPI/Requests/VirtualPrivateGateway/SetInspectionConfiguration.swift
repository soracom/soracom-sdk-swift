extension Request {

    public class func setInspectionConfiguration(
        inspectionConfiguration: JunctionInspectionConfiguration, 
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setInspectionConfiguration(inspectionConfiguration: inspectionConfiguration, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setInspectionConfiguration()) is not sufficient):

        return req
    }
}