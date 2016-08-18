// DataTrafficStats.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class DataTrafficStats: PayloadConvertible {

    public var downloadByteSizeTotal: Int64?
    public var downloadPacketSizeTotal: Int64?
    public var uploadByteSizeTotal: Int64?
    public var uploadPacketSizeTotal: Int64?

    public required init(
        downloadByteSizeTotal: Int64? = nil, 
        downloadPacketSizeTotal: Int64? = nil, 
        uploadByteSizeTotal: Int64? = nil, 
        uploadPacketSizeTotal: Int64? = nil
    ) {
        self.downloadByteSizeTotal = downloadByteSizeTotal
        self.downloadPacketSizeTotal = downloadPacketSizeTotal
        self.uploadByteSizeTotal = uploadByteSizeTotal
        self.uploadPacketSizeTotal = uploadPacketSizeTotal
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.downloadByteSizeTotal] = downloadByteSizeTotal
        payload[.downloadPacketSizeTotal] = downloadPacketSizeTotal
        payload[.uploadByteSizeTotal] = uploadByteSizeTotal
        payload[.uploadPacketSizeTotal] = uploadPacketSizeTotal

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.downloadByteSizeTotal = payload.getInt64(.downloadByteSizeTotal)
        result.downloadPacketSizeTotal = payload.getInt64(.downloadPacketSizeTotal)
        result.uploadByteSizeTotal = payload.getInt64(.uploadByteSizeTotal)
        result.uploadPacketSizeTotal = payload.getInt64(.uploadPacketSizeTotal)
        return result
    }

}

public typealias DataTrafficStatsList = [DataTrafficStats]
