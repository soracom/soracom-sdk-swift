extension Request {

    public class func registerCoupon(
        
        couponCode: String,
        responseHandler: ResponseHandler<CouponResponse>? = nil
    ) ->   Request<CouponResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerCoupon(couponCode: couponCode,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerCoupon()) is not sufficient):

        return req
    }
}