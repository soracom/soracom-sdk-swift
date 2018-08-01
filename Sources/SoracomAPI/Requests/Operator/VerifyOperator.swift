extension Request where T == NoResponseBody {

    /// Verify an operator. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/verifyOperator))

    public class func verifyOperator(
        token: VerifyOperatorsRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _verifyOperator(token: token,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_verifyOperator()) is not sufficient):

        return req
    }
    
    /// Verify an operator. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/verifyOperator))
    
    public class func verifyOperator(token: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        return verifyOperator(token: VerifyOperatorsRequest(token: token))

    }

}
