//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Get latest bill.

        Returns the latest billing amounts after applied discounts such as free tiers, etc. The amounts retrieved using this API correspond to the values before the invoice was finalized.

        Docs: https://dev.soracom.io/en/docs/api/#!/Billing/getLatestBilling
    */
    public class func _getLatestBilling(
        
        responseHandler: ResponseHandler<GetLatestBill>? = nil
    ) ->   Request<GetLatestBill> {

        let path  = "/bills/latest"

        let requestObject = Request<GetLatestBill>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
