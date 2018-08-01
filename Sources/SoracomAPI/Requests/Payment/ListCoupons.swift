extension Request {

    public class func listCoupons(
        
        responseHandler: ResponseHandler<ListCouponResponse>? = nil
    ) ->   Request<ListCouponResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listCoupons( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listCoupons()) is not sufficient):

        return req
    }
}