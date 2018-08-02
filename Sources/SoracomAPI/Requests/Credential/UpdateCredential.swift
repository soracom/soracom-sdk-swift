extension Request where T == CredentialsModel {

    /// Updates a credential. [API docs](https://dev.soracom.io/en/docs/api/#!/Credential/updateCredential)

    public class func updateCredential(
        credentials: CreateAndUpdateCredentialsModel, 
        credentialsId: String,
        responseHandler: ResponseHandler<CredentialsModel>? = nil
    ) ->   Request<CredentialsModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateCredential(credentials: credentials, credentialsId: credentialsId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateCredential()) is not sufficient):

        return req
    }
}
