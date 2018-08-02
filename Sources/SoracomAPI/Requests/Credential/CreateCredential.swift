extension Request where T == CredentialsModel {

    public class func createCredential(
        credentials: CreateAndUpdateCredentialsModel, 
        credentialsId: String,
        responseHandler: ResponseHandler<CredentialsModel>? = nil
    ) ->   Request<CredentialsModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createCredential(credentials: credentials, credentialsId: credentialsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createCredential()) is not sufficient):

        return req
    }
}
