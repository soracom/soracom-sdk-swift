extension Request where T == NoResponseBody {

    /// Verify an operator. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/verifyOperator))
    
    public class func verifyOperator(token: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        return verifyOperator(token: VerifyOperatorsRequest(token: token))

    }

}
