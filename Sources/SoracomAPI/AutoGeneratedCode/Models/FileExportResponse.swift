//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class FileExportResponse: Codable, Equatable {

    /** ファイル出力ID(リクエストにexport_mode=asyncを指定した場合） */
    public var exportedFileId: String?

    /** 出力済みファイル取得パス(リクエストにexport_mode=asyncを付与した場合） */
    public var exportedFilePath: String?

    /** ファイルダウンロードURL(export_mode指定なし、もしくはexport_mode=syncの場合 */
    public var url: String?

    public init(exportedFileId: String? = nil, exportedFilePath: String? = nil, url: String? = nil) {
        self.exportedFileId = exportedFileId
        self.exportedFilePath = exportedFilePath
        self.url = url
    }

    private enum CodingKeys: String, CodingKey {
        case exportedFileId
        case exportedFilePath
        case url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        exportedFileId = try container.decodeIfPresent(.exportedFileId)
        exportedFilePath = try container.decodeIfPresent(.exportedFilePath)
        url = try container.decodeIfPresent(.url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(exportedFileId, forKey: .exportedFileId)
        try container.encodeIfPresent(exportedFilePath, forKey: .exportedFilePath)
        try container.encodeIfPresent(url, forKey: .url)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? FileExportResponse else { return false }
      guard self.exportedFileId == object.exportedFileId else { return false }
      guard self.exportedFilePath == object.exportedFilePath else { return false }
      guard self.url == object.url else { return false }
      return true
    }

    public static func == (lhs: FileExportResponse, rhs: FileExportResponse) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}