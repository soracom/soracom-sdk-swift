//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _DataTrafficStats: Codable, Equatable {

    open var downloadByteSizeTotal: Int?

    open var downloadPacketSizeTotal: Int?

    open var uploadByteSizeTotal: Int?

    open var uploadPacketSizeTotal: Int?

    public init(downloadByteSizeTotal: Int? = nil, downloadPacketSizeTotal: Int? = nil, uploadByteSizeTotal: Int? = nil, uploadPacketSizeTotal: Int? = nil) {
        self.downloadByteSizeTotal = downloadByteSizeTotal
        self.downloadPacketSizeTotal = downloadPacketSizeTotal
        self.uploadByteSizeTotal = uploadByteSizeTotal
        self.uploadPacketSizeTotal = uploadPacketSizeTotal
    }

    private enum CodingKeys: String, CodingKey {
        case downloadByteSizeTotal
        case downloadPacketSizeTotal
        case uploadByteSizeTotal
        case uploadPacketSizeTotal
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        downloadByteSizeTotal = try container.decodeIfPresent(.downloadByteSizeTotal)
        downloadPacketSizeTotal = try container.decodeIfPresent(.downloadPacketSizeTotal)
        uploadByteSizeTotal = try container.decodeIfPresent(.uploadByteSizeTotal)
        uploadPacketSizeTotal = try container.decodeIfPresent(.uploadPacketSizeTotal)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(downloadByteSizeTotal, forKey: .downloadByteSizeTotal)
        try container.encodeIfPresent(downloadPacketSizeTotal, forKey: .downloadPacketSizeTotal)
        try container.encodeIfPresent(uploadByteSizeTotal, forKey: .uploadByteSizeTotal)
        try container.encodeIfPresent(uploadPacketSizeTotal, forKey: .uploadPacketSizeTotal)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _DataTrafficStats else { return false }
      guard self.downloadByteSizeTotal == object.downloadByteSizeTotal else { return false }
      guard self.downloadPacketSizeTotal == object.downloadPacketSizeTotal else { return false }
      guard self.uploadByteSizeTotal == object.uploadByteSizeTotal else { return false }
      guard self.uploadPacketSizeTotal == object.uploadPacketSizeTotal else { return false }
      return true
    }

    public static func == (lhs: _DataTrafficStats, rhs: _DataTrafficStats) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}