//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == ListCouponResponse {

    /**
        List coupons.

        Returns a list of currently registered coupons.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Payment/listCoupons)
    */
    public class func listCoupons(
        
        responseHandler: ResponseHandler<ListCouponResponse>? = nil
    ) ->   Request<ListCouponResponse> {

        let path  = "/coupons"

        let requestObject = Request<ListCouponResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
