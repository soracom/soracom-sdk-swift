// UpdateSpeedClassRequest.swift Generated by swagger-codegen  — Custom output templates and post-processing by CodeGeneratorForSoracomSDKSwift.Swaggerer version 0.0d1. Generated 2016-09-12T00:54:57Z

import Foundation


public class UpdateSpeedClassRequest: PayloadConvertible {

    public enum SpeedClass: String { 
        case s1_minimum  = "s1.minimum"
        case s1_slow     = "s1.slow"
        case s1_standard = "s1.standard"
        case s1_fast     = "s1.fast"
    }

    public var speedClass: SpeedClass?

    public required init(
        speedClass: SpeedClass? = nil
    ) {
        self.speedClass = speedClass
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.speedClass] = speedClass

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.speedClass = payload.decodeSpeedClass(.speedClass)
        return result
    }

}

public typealias UpdateSpeedClassRequestList = [UpdateSpeedClassRequest]
