extension Request where T == CreateCouponResponse {

    /// Create a new coupon for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Coupon/createSandboxCoupon)

    public class func createSandboxCoupon(
        request: CreateCouponRequest, 
        responseHandler: ResponseHandler<CreateCouponResponse>? = nil
    ) ->   Request<CreateCouponResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createSandboxCoupon(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createSandboxCoupon()) is not sufficient):

        return req
    }
}
