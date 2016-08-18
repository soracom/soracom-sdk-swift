// ShippingCostModel.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


/** \u767A\u9001\u6599 */
public class ShippingCostModel: PayloadConvertible {

    public enum ShippingArea: String { 
        case Hokkaido = "hokkaido"
        case KitaTohoku = "kita_tohoku"
        case MinamiTohoku = "minami_tohoku"
        case Kanto = "kanto"
        case Shinetsu = "shinetsu"
        case Chubu = "chubu"
        case Hokuriku = "hokuriku"
        case Kansai = "kansai"
        case Chugoku = "chugoku"
        case Shikoku = "shikoku"
        case Kyushu = "kyushu"
        case Okinawa = "okinawa"
    }

    /** \u767A\u9001\u5148\u30A8\u30EA\u30A2 */
    public var shippingArea: ShippingArea?
    /** \u767A\u9001\u5148\u30A8\u30EA\u30A2\u540D\u79F0 */
    public var shippingAreaName: String?
    /** \u9001\u6599 */
    public var shippingCost: Double?
    /** \u767A\u9001\u30B5\u30A4\u30BA */
    public var size: Int64?

    public required init(
        shippingArea: /* FIXME enum wtf */ShippingArea = nil, 
        shippingAreaName: String? = nil, 
        shippingCost: Double? = nil, 
        size: Int64? = nil
    ) {
        self.shippingArea = shippingArea
        self.shippingAreaName = shippingAreaName
        self.shippingCost = shippingCost
        self.size = size
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        // shippingArea: FIXME-ENUM-CASE
        payload[.shippingAreaName] = shippingAreaName
        payload[.shippingCost] = shippingCost
        payload[.size] = size

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        // shippingArea: FIXME-ENUM-CASE
        result.shippingAreaName = payload.getString(.shippingAreaName)
        result.shippingCost = payload.getDouble(.shippingCost)
        result.size = payload.getInt64(.size)
        return result
    }

}

public typealias ShippingCostModelList = [ShippingCostModel]