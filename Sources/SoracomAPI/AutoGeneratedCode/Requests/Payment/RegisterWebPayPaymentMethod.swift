//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Register credit card information for WebPay.

        Registers credit card information for WebPay payments.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Payment/registerWebPayPaymentMethod)
    */
    public class func registerWebPayPaymentMethod(
        creditCard: CreditCard, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/payment_methods/webpay"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = creditCard.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
