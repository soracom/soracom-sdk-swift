// BeamStatsResponse.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class BeamStatsResponse: PayloadConvertible {

    public var beamStatsMap: [String:SoracomBeamStats]?
    public var date: String?
    public var unixtime: Int64?

    public required init(
        beamStatsMap: [String:SoracomBeamStats]? = nil, 
        date: String? = nil, 
        unixtime: Int64? = nil
    ) {
        self.beamStatsMap = beamStatsMap
        self.date = date
        self.unixtime = unixtime
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.beamStatsMap] = beamStatsMap
        payload[.date] = date
        payload[.unixtime] = unixtime

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.beamStatsMap = payload.___SWAGGERER_POSTPROCESS_FIXME_[String:SoracomBeamStats]___(.beamStatsMap)
        result.date = payload.getString(.date)
        result.unixtime = payload.getInt64(.unixtime)
        return result
    }

}

public typealias BeamStatsResponseList = [BeamStatsResponse]