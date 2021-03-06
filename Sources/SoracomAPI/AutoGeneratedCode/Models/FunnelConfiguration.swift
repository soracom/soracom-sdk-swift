//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class FunnelConfiguration: Codable, Equatable {

    public var credentialsId: String?

    public var destination: FunnelDestination?

    public var enabled: Bool?

    public init(credentialsId: String? = nil, destination: FunnelDestination? = nil, enabled: Bool? = nil) {
        self.credentialsId = credentialsId
        self.destination = destination
        self.enabled = enabled
    }

    private enum CodingKeys: String, CodingKey {
        case credentialsId
        case destination
        case enabled
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        credentialsId = try container.decodeIfPresent(.credentialsId)
        destination = try container.decodeIfPresent(.destination)
        enabled = try container.decodeIfPresent(.enabled)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(credentialsId, forKey: .credentialsId)
        try container.encodeIfPresent(destination, forKey: .destination)
        try container.encodeIfPresent(enabled, forKey: .enabled)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? FunnelConfiguration else { return false }
      guard self.credentialsId == object.credentialsId else { return false }
      guard self.destination == object.destination else { return false }
      guard self.enabled == object.enabled else { return false }
      return true
    }

    public static func == (lhs: FunnelConfiguration, rhs: FunnelConfiguration) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
