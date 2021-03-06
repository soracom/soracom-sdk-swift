//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class PaymentDescription: Codable, Equatable {

    public var description: String?

    public var itemList: [String]?

    public init(description: String? = nil, itemList: [String]? = nil) {
        self.description = description
        self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
        case description
        case itemList
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        description = try container.decodeIfPresent(.description)
        itemList = try container.decodeArrayIfPresent(.itemList)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(itemList, forKey: .itemList)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? PaymentDescription else { return false }
      guard self.description == object.description else { return false }
      guard self.itemList == object.itemList else { return false }
      return true
    }

    public static func == (lhs: PaymentDescription, rhs: PaymentDescription) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
