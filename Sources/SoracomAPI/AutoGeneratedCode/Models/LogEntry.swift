//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class LogEntry: Codable, Equatable {

    public enum ResourceType: String, Codable {
        case subscriber = "Subscriber"
        case eventHandler = "EventHandler"
        case virtualPrivateGateway = "VirtualPrivateGateway"

        public static let cases: [ResourceType] = [
          .subscriber,
          .eventHandler,
          .virtualPrivateGateway,
        ]
    }

    public enum Service: String, Codable {
        case air = "Air"
        case beam = "Beam"
        case canal = "Canal"
        case direct = "Direct"
        case door = "Door"
        case endorse = "Endorse"
        case funnel = "Funnel"
        case gate = "Gate"

        public static let cases: [Service] = [
          .air,
          .beam,
          .canal,
          .direct,
          .door,
          .endorse,
          .funnel,
          .gate,
        ]
    }

    public var body: [String: Any]?

    public var resourceId: String?

    public var resourceType: ResourceType?

    public var service: Service?

    public var time: Int?

    public init(body: [String: Any]? = nil, resourceId: String? = nil, resourceType: ResourceType? = nil, service: Service? = nil, time: Int? = nil) {
        self.body = body
        self.resourceId = resourceId
        self.resourceType = resourceType
        self.service = service
        self.time = time
    }

    private enum CodingKeys: String, CodingKey {
        case body
        case resourceId
        case resourceType
        case service
        case time
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        body = try container.decodeAnyIfPresent(.body)
        resourceId = try container.decodeIfPresent(.resourceId)
        resourceType = try container.decodeIfPresent(.resourceType)
        service = try container.decodeIfPresent(.service)
        time = try container.decodeIfPresent(.time)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeAnyIfPresent(body, forKey: .body)
        try container.encodeIfPresent(resourceId, forKey: .resourceId)
        try container.encodeIfPresent(resourceType, forKey: .resourceType)
        try container.encodeIfPresent(service, forKey: .service)
        try container.encodeIfPresent(time, forKey: .time)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? LogEntry else { return false }
      guard NSDictionary(dictionary: self.body ?? [:]).isEqual(to: object.body ?? [:]) else { return false }
      guard self.resourceId == object.resourceId else { return false }
      guard self.resourceType == object.resourceType else { return false }
      guard self.service == object.service else { return false }
      guard self.time == object.time else { return false }
      return true
    }

    public static func == (lhs: LogEntry, rhs: LogEntry) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
