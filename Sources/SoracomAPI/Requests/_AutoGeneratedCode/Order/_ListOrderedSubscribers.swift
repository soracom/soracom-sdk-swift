//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        List ordered subscribers.

        List ordered subscribers

        Docs: https://dev.soracom.io/en/docs/api/#!/Order/listOrderedSubscribers
    */
    public class func _listOrderedSubscribers(
        
        orderId: String,
        lastEvaluatedKey: String? = nil,
        limit: Int? = nil,
        responseHandler: ResponseHandler<ListOrderedSubscriberResponse>? = nil
    ) ->   Request<ListOrderedSubscriberResponse> {

        let path  = "/orders/\(orderId)/subscribers"

        let requestObject = Request<ListOrderedSubscriberResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "lastEvaluatedKey": lastEvaluatedKey,
            "limit": limit
        ])

        return requestObject
    }

}
