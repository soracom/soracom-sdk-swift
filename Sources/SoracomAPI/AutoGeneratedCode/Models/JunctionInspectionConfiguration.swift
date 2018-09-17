//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class JunctionInspectionConfiguration: Codable, Equatable {

    public var enabled: Bool?

    public var report: FunnelConfiguration?

    public init(enabled: Bool? = nil, report: FunnelConfiguration? = nil) {
        self.enabled = enabled
        self.report = report
    }

    private enum CodingKeys: String, CodingKey {
        case enabled
        case report
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        enabled = try container.decodeIfPresent(.enabled)
        report = try container.decodeIfPresent(.report)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(enabled, forKey: .enabled)
        try container.encodeIfPresent(report, forKey: .report)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? JunctionInspectionConfiguration else { return false }
      guard self.enabled == object.enabled else { return false }
      guard self.report == object.report else { return false }
      return true
    }

    public static func == (lhs: JunctionInspectionConfiguration, rhs: JunctionInspectionConfiguration) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
