//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class LastSeen: Codable, Equatable {

    public var rssi: Int?

    public var snr: Int?

    public var time: DateTime?

    public init(rssi: Int? = nil, snr: Int? = nil, time: DateTime? = nil) {
        self.rssi = rssi
        self.snr = snr
        self.time = time
    }

    private enum CodingKeys: String, CodingKey {
        case rssi
        case snr
        case time
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        rssi = try container.decodeIfPresent(.rssi)
        snr = try container.decodeIfPresent(.snr)
        time = try container.decodeIfPresent(.time)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(rssi, forKey: .rssi)
        try container.encodeIfPresent(snr, forKey: .snr)
        try container.encodeIfPresent(time, forKey: .time)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? LastSeen else { return false }
      guard self.rssi == object.rssi else { return false }
      guard self.snr == object.snr else { return false }
      guard self.time == object.time else { return false }
      return true
    }

    public static func == (lhs: LastSeen, rhs: LastSeen) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
