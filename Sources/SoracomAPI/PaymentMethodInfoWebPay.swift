// PaymentMethodInfoWebPay.swift Created by mason on 2017-07-26.


/// Encapsulates the data for registering a payment method.

public struct PaymentMethodInfoWebPay {

    public var cvc: String
    public var expireMonth: Int
    public var expireYear: Int
    public var name: String
    public var number: String

    public init(cvc: String, expireMonth: Int, expireYear: Int, name: String, number: String) {

        self.cvc         = cvc
        self.expireMonth = expireMonth
        self.expireYear  = expireYear
        self.name        = name
        self.number      = number
    }

}
