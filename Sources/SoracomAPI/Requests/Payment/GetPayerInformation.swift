extension Request {

    public class func getPayerInformation(
        
        responseHandler: ResponseHandler<RegisterPayerInformationModel>? = nil
    ) ->   Request<RegisterPayerInformationModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getPayerInformation( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getPayerInformation()) is not sufficient):

        return req
    }
}