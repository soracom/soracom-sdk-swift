//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == ListOrderResponse {

    /**
        List confirmed orders.

        Returns a list of confirmed orders.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Order/listOrders)
    */
    public class func listOrders(
        
        responseHandler: ResponseHandler<ListOrderResponse>? = nil
    ) ->   Request<ListOrderResponse> {

        let path  = "/orders"

        let requestObject = Request<ListOrderResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
