//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _GetOperatorResponse: Codable, Equatable {

    open var createDate: String

    open var description: String

    open var email: String

    open var operatorId: String

    open var rootOperatorId: String

    open var updateDate: String

    public init(createDate: String, description: String, email: String, operatorId: String, rootOperatorId: String, updateDate: String) {
        self.createDate = createDate
        self.description = description
        self.email = email
        self.operatorId = operatorId
        self.rootOperatorId = rootOperatorId
        self.updateDate = updateDate
    }

    private enum CodingKeys: String, CodingKey {
        case createDate
        case description
        case email
        case operatorId
        case rootOperatorId
        case updateDate
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        createDate = try container.decode(.createDate)
        description = try container.decode(.description)
        email = try container.decode(.email)
        operatorId = try container.decode(.operatorId)
        rootOperatorId = try container.decode(.rootOperatorId)
        updateDate = try container.decode(.updateDate)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(createDate, forKey: .createDate)
        try container.encode(description, forKey: .description)
        try container.encode(email, forKey: .email)
        try container.encode(operatorId, forKey: .operatorId)
        try container.encode(rootOperatorId, forKey: .rootOperatorId)
        try container.encode(updateDate, forKey: .updateDate)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _GetOperatorResponse else { return false }
      guard self.createDate == object.createDate else { return false }
      guard self.description == object.description else { return false }
      guard self.email == object.email else { return false }
      guard self.operatorId == object.operatorId else { return false }
      guard self.rootOperatorId == object.rootOperatorId else { return false }
      guard self.updateDate == object.updateDate else { return false }
      return true
    }

    public static func == (lhs: _GetOperatorResponse, rhs: _GetOperatorResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
