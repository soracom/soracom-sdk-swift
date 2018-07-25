{% include "Includes/Header.stencil" %}

import Foundation

public class APIRequest<ResponseType: APIResponseValue> {

    public let service: APIService<ResponseType>
    public private(set) var parameters: [String: Any]
    public let encodeBody: (() throws -> Data)?
    public var headers: [String: String] = [:]

    public var path: String {
        return service.path
    }

    public init(service: APIService<ResponseType>, parameters: [String: Any] = [:], headers: [String: String] = [:], encodeBody: (() throws -> Data)? = nil) {
        self.service = service
        self.parameters = parameters
        self.headers = headers
        self.encodeBody = encodeBody
    }

    public func addHeader(name: String, value: String) {
        if !value.isEmpty {
            headers[name] = value
        }
    }
}

extension APIRequest: CustomStringConvertible {

    public var description: String {
        var string = "\(service.name): \(service.method) \(path)"
        if !parameters.isEmpty {
            string += "?" + parameters.map {"\($0)=\($1)"}.joined(separator: "&")
        }
        return string
    }
}

extension APIRequest: CustomDebugStringConvertible {

    public var debugDescription: String {
        var string = description
        if let encodeBody = encodeBody,
            let data = try? encodeBody(),
            let bodyString = String(data: data, encoding: .utf8) {
            string += "\nbody: \(bodyString)"
        }
        return string
    }
}
