{% include "Includes/Header.stencil" %}

public struct APIService<ResponseType: APIResponseValue> {

    public let id: String
    public let tag: String
    public let method: String
    public let path: String
    public let hasBody: Bool
    public let authorization: Authorization?

    public init(id: String, tag: String = "", method:String, path:String, hasBody: Bool, authorization: Authorization? = nil) {
        self.id = id
        self.tag = tag
        self.method = method
        self.path = path
        self.hasBody = hasBody
        self.authorization = authorization
    }
}

extension APIService: CustomStringConvertible {

    public var name: String {
        return "\(tag.isEmpty ? "" : "\(tag).")\(id)"
    }

    public var description: String {
        return "\(name): \(method) \(path)"
    }
}
