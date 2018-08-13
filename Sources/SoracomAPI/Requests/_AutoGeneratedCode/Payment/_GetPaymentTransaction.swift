//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getPaymentTransaction(
        
        paymentTransactionId: String,
        responseHandler: ResponseHandler<GetPaymentTransactionResult>? = nil
    ) ->   Request<GetPaymentTransactionResult> {

        let path  = "/payment_history/transactions/\(paymentTransactionId)"

        let requestObject = Request<GetPaymentTransactionResult>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
