extension Request where T == NoResponseBody {

    /// Register a new operator. In the sandbox environment, this is one of the first steps that needs to be done. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/createOperator))

    public class func createOperator(
        request: RegisterOperatorsRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createOperator(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createOperator()) is not sufficient):

        return req
    }
    
    
    /// Register a new operator. In the sandbox environment, this is one of the first steps that needs to be done. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/createOperator))
    
    public class func createOperator(
        _ email: String,
        password: String,
        coverageTypes: [String]? = nil,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
        ) -> Request<NoResponseBody> {
        
        let req = Request<NoResponseBody>.init("/operators", responseHandler: responseHandler)
        
        let requestObject = RegisterOperatorsRequest(email: email, password: password, coverageTypes: coverageTypes)
        if let coverageTypes = coverageTypes {
            requestObject.coverageTypes = coverageTypes
        }
        
        req.messageBody = requestObject.toData()
        
        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
        req.expectedHTTPStatus = 201
        
        return req
        
        // DISCUSSION
        //
        //    print(response)
        //    print(responseData)
        //    print(error)
        
        // 0.) RESPONSE IF IT WORKS:
        //        Optional(<NSHTTPURLResponse: 0x60000002b500> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 201, headers {...} })
        //    Optional("")
        //    nil
        
        // 1.) RESPONSE IF ALREADY REGISTERED:
        //        Optional(<NSHTTPURLResponse: 0x62000002bee0> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 400, headers {...} })
        //    Optional("{\"code\":\"AUM0003\",\"message\":\"This email is already registered.\"}")
        
        // NOTE: It seems to let me create the same user over and over. But it failed "already registered" when I used my previous credentials. So maybe it lets you create multiple times if the sandbox user being created has no records/activity associated with it?
    }
}
