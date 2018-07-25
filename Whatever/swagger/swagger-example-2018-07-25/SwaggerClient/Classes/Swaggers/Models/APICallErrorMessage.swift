//
// APICallErrorMessage.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class APICallErrorMessage: Codable {

    /** エラーコード */
    public var code: String
    /** エラーメッセージ。リクエスト時にX-Soracom-Langヘッダーに言語(en,ja)を設定するとその言語のメッセージがセットされます。 */
    public var message: String


    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(code, forKey: "code")
        try container.encode(message, forKey: "message")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        code = try container.decode(String.self, forKey: "code")
        message = try container.decode(String.self, forKey: "message")
    }
}

