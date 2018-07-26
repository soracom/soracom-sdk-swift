//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

open class _ProductModel: Codable, Equatable {

    /** 商品種別 */
    public enum ProductType: String, Codable {
        case sim = "sim"
        case networkModule = "network_module"

        public static let cases: [ProductType] = [
          .sim,
          .networkModule,
        ]
    }

    /** 商品販売個数 */
    open var count: Double?

    /** 最大購入数量 */
    open var maxQuantity: Int?

    /** 商品販売個数ごとの価格 */
    open var price: Double?

    /** 商品コード */
    open var productCode: String?

    /** 商品説明ページURL */
    open var productInfoURL: String?

    /** 商品名 */
    open var productName: String?

    /** 商品種別 */
    open var productType: ProductType?

    /** 商品プロパティ */
    open var properties: [String: String]?

    public init(count: Double? = nil, maxQuantity: Int? = nil, price: Double? = nil, productCode: String? = nil, productInfoURL: String? = nil, productName: String? = nil, productType: ProductType? = nil, properties: [String: String]? = nil) {
        self.count = count
        self.maxQuantity = maxQuantity
        self.price = price
        self.productCode = productCode
        self.productInfoURL = productInfoURL
        self.productName = productName
        self.productType = productType
        self.properties = properties
    }

    private enum CodingKeys: String, CodingKey {
        case count
        case maxQuantity
        case price
        case productCode
        case productInfoURL
        case productName
        case productType
        case properties
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        count = try container.decodeIfPresent(.count)
        maxQuantity = try container.decodeIfPresent(.maxQuantity)
        price = try container.decodeIfPresent(.price)
        productCode = try container.decodeIfPresent(.productCode)
        productInfoURL = try container.decodeIfPresent(.productInfoURL)
        productName = try container.decodeIfPresent(.productName)
        productType = try container.decodeIfPresent(.productType)
        properties = try container.decodeIfPresent(.properties)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(count, forKey: .count)
        try container.encodeIfPresent(maxQuantity, forKey: .maxQuantity)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(productCode, forKey: .productCode)
        try container.encodeIfPresent(productInfoURL, forKey: .productInfoURL)
        try container.encodeIfPresent(productName, forKey: .productName)
        try container.encodeIfPresent(productType, forKey: .productType)
        try container.encodeIfPresent(properties, forKey: .properties)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? _ProductModel else { return false }
      guard self.count == object.count else { return false }
      guard self.maxQuantity == object.maxQuantity else { return false }
      guard self.price == object.price else { return false }
      guard self.productCode == object.productCode else { return false }
      guard self.productInfoURL == object.productInfoURL else { return false }
      guard self.productName == object.productName else { return false }
      guard self.productType == object.productType else { return false }
      guard self.properties == object.properties else { return false }
      return true
    }

    public static func == (lhs: _ProductModel, rhs: _ProductModel) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}