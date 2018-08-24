//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class RegisterPayerInformationModel: Codable, Equatable {

    /** 企業名 */
    public var companyName: String?

    /** 部署 */
    public var department: String?

    /** 氏名 */
    public var fullName: String?

    public init(companyName: String? = nil, department: String? = nil, fullName: String? = nil) {
        self.companyName = companyName
        self.department = department
        self.fullName = fullName
    }

    private enum CodingKeys: String, CodingKey {
        case companyName
        case department
        case fullName
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        companyName = try container.decodeIfPresent(.companyName)
        department = try container.decodeIfPresent(.department)
        fullName = try container.decodeIfPresent(.fullName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(companyName, forKey: .companyName)
        try container.encodeIfPresent(department, forKey: .department)
        try container.encodeIfPresent(fullName, forKey: .fullName)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? RegisterPayerInformationModel else { return false }
      guard self.companyName == object.companyName else { return false }
      guard self.department == object.department else { return false }
      guard self.fullName == object.fullName else { return false }
      return true
    }

    public static func == (lhs: RegisterPayerInformationModel, rhs: RegisterPayerInformationModel) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}