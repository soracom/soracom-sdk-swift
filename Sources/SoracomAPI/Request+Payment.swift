// Request+Payment.swift Created by mason on 2016-04-15. Copyright © 2016 Soracom, Inc. All rights reserved.

extension Request {

    /// Register credit card information. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Payment/registerWebPayPaymentMethod))
    
    public class func registerWebPayPaymentMethod(_ info: PaymentMethodInfoWebPay, responseHandler: ResponseHandler? = nil) -> Request {
        let req = self.init("/payment_methods/webpay", responseHandler: responseHandler)
        req.payload = [
            .cvc         : info.cvc,
            .expireMonth : info.expireMonth,
            .expireYear  : info.expireYear,
            .name        : info.name,
            .number      : info.number,
        ]
        
        req.expectedHTTPStatus = 201 // FIXME: file a bug against the API docs; they say 200 OK is returned on success, but it's really 201 CREATED.
        return req
    }

}
