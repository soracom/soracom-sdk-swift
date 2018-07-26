//
// FileExportResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class FileExportResponse: Codable {

    /** ファイル出力ID(リクエストにexport_mode&#x3D;asyncを指定した場合） */
    public var exportedFileId: String?
    /** 出力済みファイル取得パス(リクエストにexport_mode&#x3D;asyncを付与した場合） */
    public var exportedFilePath: String?
    /** ファイルダウンロードURL(export_mode指定なし、もしくはexport_mode&#x3D;syncの場合 */
    public var url: String?


    
    public init(exportedFileId: String?, exportedFilePath: String?, url: String?) {
        self.exportedFileId = exportedFileId
        self.exportedFilePath = exportedFilePath
        self.url = url
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(exportedFileId, forKey: "exportedFileId")
        try container.encodeIfPresent(exportedFilePath, forKey: "exportedFilePath")
        try container.encodeIfPresent(url, forKey: "url")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        exportedFileId = try container.decodeIfPresent(String.self, forKey: "exportedFileId")
        exportedFilePath = try container.decodeIfPresent(String.self, forKey: "exportedFilePath")
        url = try container.decodeIfPresent(String.self, forKey: "url")
    }
}
