// PaymentMethodInfoWebPay.swift Created by mason on 2017-07-26. 


/// Encapsulates the data for registering a payment method.

public struct PaymentMethodInfoWebPay {
    var cvc: String
    var expireMonth: Int
    var expireYear: Int
    var name: String
    var number: String
}
