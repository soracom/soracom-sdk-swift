//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _SmsForwardingRequest: Codable, Equatable {

    /** Encoding type of the message body. `1` indicates the body is `DCS_7BIT` that only supports single byte characters. `2` is `DCS_UCS2` that supports multi-byte text. When omitted, it is treated as `2` (`DCS_UCS2`). */
    open var encodingType: Int?

    open var payload: String?

    public init(encodingType: Int? = nil, payload: String? = nil) {
        self.encodingType = encodingType
        self.payload = payload
    }

    private enum CodingKeys: String, CodingKey {
        case encodingType
        case payload
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        encodingType = try container.decodeIfPresent(.encodingType)
        payload = try container.decodeIfPresent(.payload)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(encodingType, forKey: .encodingType)
        try container.encodeIfPresent(payload, forKey: .payload)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _SmsForwardingRequest else { return false }
      guard self.encodingType == object.encodingType else { return false }
      guard self.payload == object.payload else { return false }
      return true
    }

    public static func == (lhs: _SmsForwardingRequest, rhs: _SmsForwardingRequest) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
