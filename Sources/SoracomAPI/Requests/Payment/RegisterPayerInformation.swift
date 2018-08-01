extension Request {

    public class func registerPayerInformation(
        req: RegisterPayerInformationModel, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerPayerInformation(req: req,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerPayerInformation()) is not sufficient):

        return req
    }
}