extension Request where T == GetSignupTokenResponse {

    public class func getSignupToken(
        auth: GetSignupTokenRequest, 
        email: String,
        responseHandler: ResponseHandler<GetSignupTokenResponse>? = nil
    ) ->   Request<GetSignupTokenResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getSignupToken(auth: auth, email: email,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getSignupToken()) is not sufficient):

        return req
    }
    
    /// Generate a sign-up token to activate a sandbox account. This is necessary to activate an account in the API Sandbox, and for this step (only) you need to use a real authKey and authKeyId for a SAM user in the non-sandbox production environment. See [this page](https://dev.soracom.io/jp/docs/api_sandbox/) for details. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Operator/getSignupToken)
    
    public class func getSignupToken(
        email: String,
        authKeyId: String,
        authKey: String,
        responseHandler: ResponseHandler<GetSignupTokenResponse>? = nil
    ) -> Request<GetSignupTokenResponse> {
        
        return getSignupToken(auth: GetSignupTokenRequest(authKey: authKey, authKeyId: authKeyId), email: email, responseHandler: responseHandler)
    }

}
