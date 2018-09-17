//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == GetOrderResponse {

    /**
        Get confirmed order.

        Returns a confirmed order.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Order/getOrder)
    */
    public class func getOrder(
        
        orderId: String,
        responseHandler: ResponseHandler<GetOrderResponse>? = nil
    ) ->   Request<GetOrderResponse> {

        let path  = "/orders/\(orderId)"

        let requestObject = Request<GetOrderResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
