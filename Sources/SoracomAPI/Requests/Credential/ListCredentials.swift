extension Request {

    public class func listCredentials(
        
        responseHandler: ResponseHandler<[CredentialsModel]>? = nil
    ) ->   Request<[CredentialsModel]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listCredentials( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listCredentials()) is not sufficient):

        return req
    }
}