//
// GetPaymentMethodResult.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


public class GetPaymentMethodResult: JSONEncodable {
    public enum ErrorCode: String { 
        case Success = "success"
        case Processing = "processing"
        case InvalidRequest = "invalid_request"
        case InvalidNumber = "invalid_number"
        case IncorrectNumber = "incorrect_number"
        case InvalidName = "invalid_name"
        case InvalidExpiryMonth = "invalid_expiry_month"
        case InvalidExpiryYear = "invalid_expiry_year"
        case InvalidExpiry = "invalid_expiry"
        case IncorrectExpiry = "incorrect_expiry"
        case InvalidCvc = "invalid_cvc"
        case IncorrectCvc = "incorrect_cvc"
        case CardDeclined = "card_declined"
        case Missing = "missing"
        case ProcessingError = "processing_error"
    }
    public enum ProviderType: String { 
        case WebPay = "WebPay"
    }
    /** \u30A8\u30E9\u30FC\u30B3\u30FC\u30C9\uFF08\u652F\u6255\u3044\u60C5\u5831\u304C\u7121\u52B9\u306A\u5834\u5408\u306E\u307F\uFF09 */
    public var errorCode: ErrorCode?
    /** \u30A8\u30E9\u30FC\u30E1\u30C3\u30BB\u30FC\u30B8\uFF08\u652F\u6255\u3044\u60C5\u5831\u304C\u7121\u52B9\u306A\u5834\u5408\u306E\u307F */
    public var errorMessage: String?
    /** \u652F\u6255\u3044\u60C5\u5831 */
    public var properties: String?
    /** \u8AB2\u91D1\u30D7\u30ED\u30D0\u30A4\u30C0\u7A2E\u5225 */
    public var providerType: ProviderType?
    /** \u767B\u9332\u65E5 */
    public var updateDate: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["errorCode"] = self.errorCode?.rawValue
        nillableDictionary["errorMessage"] = self.errorMessage
        nillableDictionary["properties"] = self.properties
        nillableDictionary["providerType"] = self.providerType?.rawValue
        nillableDictionary["updateDate"] = self.updateDate
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
