//
// RegisterPayerInformationModel.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class RegisterPayerInformationModel: Codable {

    /** 企業名 */
    public var companyName: String?
    /** 部署 */
    public var department: String?
    /** 氏名 */
    public var fullName: String?


    
    public init(companyName: String?, department: String?, fullName: String?) {
        self.companyName = companyName
        self.department = department
        self.fullName = fullName
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(companyName, forKey: "companyName")
        try container.encodeIfPresent(department, forKey: "department")
        try container.encodeIfPresent(fullName, forKey: "fullName")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        companyName = try container.decodeIfPresent(String.self, forKey: "companyName")
        department = try container.decodeIfPresent(String.self, forKey: "department")
        fullName = try container.decodeIfPresent(String.self, forKey: "fullName")
    }
}

