{% include "Includes/Header.stencil" %}

import Foundation

public protocol RequestBehaviour {

    /// runs first and allows the requests to be modified
    func modifyRequest(request: AnyRequest, urlRequest: URLRequest) -> URLRequest

    /// called before request is sent
    func beforeSend(request: AnyRequest)

    /// called when request successfuly returns a 200 range response
    func onSuccess(request: AnyRequest, result: Any)

    /// called when request fails with an error. This will not be called if the request returns a known response even if the a status code is out of the 200 range
    func onFailure(request: AnyRequest, error: APIError)

    /// called if the request recieves a network response. This is not called if request fails validation or encoding
    func onResponse(request: AnyRequest, response: AnyResponse)
}

// Provides empty defaults so that each function becomes optional
public extension RequestBehaviour {
    func beforeSend(request: AnyRequest) {}
    func onSuccess(request: AnyRequest, result: Any) {}
    func onFailure(request: AnyRequest, error: APIError) {}
    func onResponse(request: AnyRequest, response: AnyResponse) {}
    func modifyRequest(request: AnyRequest, urlRequest: URLRequest) -> URLRequest { return urlRequest }
}

// Group different RequestBehaviours together
struct RequestBehaviourGroup {

    let request: AnyRequest
    let behaviours: [RequestBehaviour]

    init<T>(request: APIRequest<T>, behaviours: [RequestBehaviour]) {
        self.request = request.asAny()
        self.behaviours = behaviours
    }

    func beforeSend() {
        behaviours.forEach {
            $0.beforeSend(request: request)
        }
    }

    func onSuccess(result: Any) {
        behaviours.forEach {
            $0.onSuccess(request: request, result: result)
        }
    }

    func onFailure(error: APIError) {
        behaviours.forEach {
            $0.onFailure(request: request, error: error)
        }
    }

    func onResponse(response: AnyResponse) {
        behaviours.forEach {
            $0.onResponse(request: request, response: response)
        }
    }

    func modifyRequest(_ urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        behaviours.forEach {
            urlRequest = $0.modifyRequest(request: request, urlRequest: urlRequest)
        }
        return urlRequest
    }
}


//MARK: Type erased Requests and Responses

public typealias AnyResponse = APIResponse<AnyResponseValue>

public class AnyRequest: APIRequest<AnyResponseValue> {
    private let requestPath: String

    override public var path: String {
        return requestPath
    }

    init<T>(request: APIRequest<T>) {
        requestPath = request.path
        super.init(service: request.service.asAny(), parameters: request.parameters, headers: request.headers, encodeBody: request.encodeBody)
    }
}

public struct AnyResponseValue: APIResponseValue, CustomDebugStringConvertible, CustomStringConvertible {

    public typealias SuccessType = Any

    public let statusCode: Int
    public let successful: Bool
    public let response: Any
    public let responseEnum: Any
    public let success: Any?

    public init(statusCode: Int, successful: Bool, response: Any, responseEnum: Any, success: Any?) {
        self.statusCode = statusCode
        self.successful = successful
        self.response = response
        self.responseEnum = responseEnum
        self.success = success
    }

    public init(statusCode: Int, data: Data) throws {
        fatalError()
    }

    public var description:String {
        return "\(responseEnum)"
    }

    public var debugDescription: String {
        if let debugDescription = responseEnum as? CustomDebugStringConvertible {
            return debugDescription.debugDescription
        } else {
            return "\(responseEnum)"
        }
    }
}

extension APIResponseValue {
    func asAny() -> AnyResponseValue {
        return AnyResponseValue(statusCode: statusCode, successful: successful, response: response, responseEnum: self, success: success)
    }
}

extension APIResponse {
    func asAny() -> APIResponse<AnyResponseValue> {
        return APIResponse<AnyResponseValue>(request: request.asAny(), result: result.map{ $0.asAny() }, urlRequest: urlRequest, urlResponse: urlResponse, data: data, timeline: timeline)
    }
}

extension APIRequest {
    func asAny() -> AnyRequest {
        return AnyRequest(request: self)
    }
}

extension APIService {
    func asAny() -> APIService<AnyResponseValue> {
        return APIService<AnyResponseValue>(id: id, tag: tag, method: method, path: path, hasBody: hasBody, authorization: authorization)
    }
}
