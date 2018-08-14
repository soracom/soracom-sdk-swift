//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Get billing history.

        Returns past billing history (after applied discounts such as free tiers, etc., inclusive of tax). This API only returns the billing amounts that have been finalized at the end of the month.

        Docs: https://dev.soracom.io/en/docs/api/#!/Billing/getBillingHistory
    */
    public class func _getBillingHistory(
        
        responseHandler: ResponseHandler<GetBillingHistoryResponse>? = nil
    ) ->   Request<GetBillingHistoryResponse> {

        let path  = "/bills"

        let requestObject = Request<GetBillingHistoryResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
