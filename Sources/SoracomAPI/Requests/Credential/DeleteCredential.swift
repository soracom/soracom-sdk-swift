extension Request where T == NoResponseBody {

    public class func deleteCredential(
        
        credentialsId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteCredential(credentialsId: credentialsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteCredential()) is not sufficient):

        return req
    }
}
