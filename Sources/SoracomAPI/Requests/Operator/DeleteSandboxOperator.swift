extension Request where T == NoResponseBody {

    /// Delete the operator specified by `operatorId`. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Operator/deleteSandboxOperator)

    public class func deleteSandboxOperator(
        
        operatorId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteSandboxOperator(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteSandboxOperator()) is not sufficient):

        return req
    }
}
