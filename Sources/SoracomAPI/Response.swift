// Response.swift reated by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

open class BaseResponse {
    
    public let baseRequest: BaseRequest
    

    /// The underlying system response object (which exposes some details like HTTP headers, HTTP version, etc). This object should always be present upon success, but may be nil when some kind of error has occurred (or in automated testing scenarios).
    
    public var underlyingURLResponse: HTTPURLResponse?
    
    public var statusCode: Int? {
        
        get {
            return underlyingURLResponse?.statusCode
        }
    }
    
    
    /// The raw data received with the response (if any).
    
    public var data: Data?
    
    
    /// Returns `self.data` as a UTF-8 string.
    
    public var text: String? {
        guard let data = data else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
    /// The actual HTTP status returned by the underlying HTTP request. May be nil, e.g. if error happened before HTTP response was received.
    
    public var HTTPStatus: Int? {
        return underlyingURLResponse?.statusCode
    }


    

    public init(request: BaseRequest, underlyingURLResponse: HTTPURLResponse?, data: Data? = nil, underlyingError: NSError? = nil, internalError: APIError? = nil) {
        self.baseRequest = request;
        self.underlyingURLResponse = underlyingURLResponse
        self.data                  = data
        
        if let err = underlyingError {
            _error = APIError(underlyingError: err)
        }
    }
    

    
    /// An `error` value of `nil` indicates success. A non-nil value indicates an error has occured. Usually, an error will be returned by the API server, but other errors are possible. E.g., a client-side error accessing the network.
    
    public var error: APIError? {
        
        guard _error == nil else {
            return _error
        }
        return nil
    }
    private var _error: APIError? = nil // can be set at init time, when client-side err occurs before networking

}

/// Response represents the result of an API call, which is typically the response by the Soracom API server, but might instead be an error.
///
/// There are three basic failure modes:
/// - the API returns an error/failure
/// - the client app encountered a local error trying to access the API (e.g., network not available)
/// - the client failed to parse the response (indicating a bug in either the client (this SDK) or the API server)
///
/// If no error occurs, this object provides access to the response data from the API server.
///
/// This object also provides information about whether an error (of any of the types above) occurred, and provides access to the error.

open class Response<T>: BaseResponse {
    
    /// The normal way that Response objects are instantiated (by Request). Outside of testing, it would be unusual to need to manually init a Response.
    
    public init(request: Request<T>, underlyingURLResponse: HTTPURLResponse?, data: Data? = nil, underlyingError: NSError? = nil, internalError: APIError? = nil) {
        
        self.request               = request
        super.init(request: request, underlyingURLResponse: underlyingURLResponse, data: data, underlyingError: underlyingError, internalError: internalError)
    }
    
    
    /// The originating `Request` instance, for which the receiver is a matched pair. The request has the details about what was requested and what the expectations were, while the result has the details of what actually came back from the sever (or what error occurred).
    
    public let request: Request<T>
    
    
    /// Creates and returns an object from the HTTP response from the API server, assuming it included a JSON payload that could be successfully parsed as the expected object type.

//    open func parse() -> T? {
//
//        guard let data = data else {
//            return nil
//        }
//
//        var result: T? = nil
//
//        let d = JSONDecoder()
//
//        do {
//
//            // THIS WORKS, BUT WE'D HAVE TO AUTOGEN HUGE IF SERIES:
////            if T.self == Group.self {
////                print("bleet")
////                result = try d.decode(Group.self, from: data) as? T
////            } else if T.self == AuthResponse.self {
////                print("blart")
////                result = try d.decode(AuthResponse.self, from: data) as? T
////            } else {
////                result = try d.decodeAny(T.self, from: data) as? T
////            }
//        } catch let err {
//            Metrics.record(type: .decodeFailure, description: "\(self).parse() failed", error: err, data: data)
//        }
//        return result;
//    }

    /// An `error` value of `nil` indicates success. A non-nil value indicates an error has occured. Usually, an error will be returned by the API server, but other errors are possible. E.g., a client-side error accessing the network.
    
    public override var error: APIError? {
        
        guard _error == nil else {
            return _error
        }
        
        guard HTTPStatus == baseRequest.expectedHTTPStatus else {
            
            // The API reported an error. Let's see if we can parse this as a regular API error response, since that
            // will presumably yield a more informative error message. If not, just create a generic error here.
            // FIXME: See if we can add real err codes for client-side errs, that don't potentially conflict with API-side err codes.
            
            return APIError.from(jsonData: data) ??
                APIError(code: "CLI0666", message: "got HTTP status \(String(describing: HTTPStatus)), but expected \(baseRequest.expectedHTTPStatus)")
        }
        
        guard parse() != nil else {
            return APIError(code: "CLI0666", message: "could not decode response payload")
        }
        
        return nil
    }
    private var _error: APIError? = nil // can be set at init time, when client-side err occurs before networking

}


extension Response: CustomStringConvertible {
    
    /// Return an attractive and understandable end-user-facing textual representations of the response. Intended for debugging and learning. (And maybe verbose logging?)

    public var description: String {
        let f = RequestResponseFormatter()
        return f.formatResponse(self)
    }
}
