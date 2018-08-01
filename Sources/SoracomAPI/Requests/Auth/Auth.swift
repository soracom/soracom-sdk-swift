extension Request where T == AuthResponse {

    public class func auth(
        auth: AuthRequest,
        responseHandler: ResponseHandler<AuthResponse>? = nil
    ) ->   Request<AuthResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _auth(auth: auth,  responseHandler: responseHandler)

        return req
    }
    
    /// Authenticate using one of the supported forms of credentials, and obtain an API Key and API Token for use when making subsequent requests. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth))
    ///
    /// - parameter credentials: A credentials object that can (optionally) override the default credentials. Unlike most
    ///   API requests, which send the API Key and API Token in HTTP headers to authenticate, the `auth()` method requires
    ///   authenticating with `.RootAccount`, `.SAM`, or `.AuthKey` credentials.
    ///
    ///   If no credentials are supplied, the "default" credentials, if they exist, are used. If no credentials are supplied
    ///   and none can be found, the request will fail.
    ///
    /// Upon success, the Response will have a payload that can be used to initialize an AuthResponse struct, that contains the API Key and API Token.
    
    public class func auth(_ credentials: SoracomCredentials? = nil, responseHandler: ResponseHandler<AuthResponse>? = nil) -> Request<AuthResponse> {
        
        let req = Request<AuthResponse>.init("/auth", responseHandler: responseHandler)
        let timeout = 86400
        
        req.credentials = credentials ?? SoracomCredentials.defaultSavedCredentials()
        
        guard let requestObject = AuthRequest(from: req.credentials) else {
            fatalError("unsupported auth type other than RootAccount, SAM, or AuthKey. ")
            // FIXME: fatalError is a little extreme bro... just make the request error.
        }
        
        requestObject.tokenTimeoutSeconds = timeout
        
        return auth(auth: requestObject)
    }

}
