//
// APICallError.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class APICallError: Codable {

    public var errorMessage: APICallErrorMessage?
    public var httpStatus: Int?


    
    public init(errorMessage: APICallErrorMessage?, httpStatus: Int?) {
        self.errorMessage = errorMessage
        self.httpStatus = httpStatus
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(errorMessage, forKey: "errorMessage")
        try container.encodeIfPresent(httpStatus, forKey: "httpStatus")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        errorMessage = try container.decodeIfPresent(APICallErrorMessage.self, forKey: "errorMessage")
        httpStatus = try container.decodeIfPresent(Int.self, forKey: "httpStatus")
    }
}

