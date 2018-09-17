// CreditCard+Extras.swift Created by Mason Mark on 2018-08-29.

extension CreditCard {
    
    /// Returns a `CreditCard` record for testing. The record contains the (fake) values that can be used as a valid credit card in the API Sandbox (and by automated tests).
    
    public static var testCard: CreditCard {
        
        return CreditCard(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
          // (This fake credit card info comes from the API Sandbox docs.)
    }
}
