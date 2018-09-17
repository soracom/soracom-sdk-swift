//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class ErrorType: Codable, Equatable {

    public var code: Int?

    public var fields: String?

    public var message: String?

    public init(code: Int? = nil, fields: String? = nil, message: String? = nil) {
        self.code = code
        self.fields = fields
        self.message = message
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case fields
        case message
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        code = try container.decodeIfPresent(.code)
        fields = try container.decodeIfPresent(.fields)
        message = try container.decodeIfPresent(.message)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(fields, forKey: .fields)
        try container.encodeIfPresent(message, forKey: .message)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ErrorType else { return false }
      guard self.code == object.code else { return false }
      guard self.fields == object.fields else { return false }
      guard self.message == object.message else { return false }
      return true
    }

    public static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
