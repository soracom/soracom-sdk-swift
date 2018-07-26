//
// OrderedSubscriber.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class OrderedSubscriber: Codable {

    /** IMSI */
    public var imsi: String?
    /** MSISDN */
    public var msisdn: String?
    /** serialNumber */
    public var serialNumber: String?


    
    public init(imsi: String?, msisdn: String?, serialNumber: String?) {
        self.imsi = imsi
        self.msisdn = msisdn
        self.serialNumber = serialNumber
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(imsi, forKey: "imsi")
        try container.encodeIfPresent(msisdn, forKey: "msisdn")
        try container.encodeIfPresent(serialNumber, forKey: "serialNumber")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        imsi = try container.decodeIfPresent(String.self, forKey: "imsi")
        msisdn = try container.decodeIfPresent(String.self, forKey: "msisdn")
        serialNumber = try container.decodeIfPresent(String.self, forKey: "serialNumber")
    }
}
