// Response.swift reated by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

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

public struct Response {
    
    /// The normal way that Response objects are instantiated (by Request). Outside of testing, it would be unusual to need to manually init a Response.
    
    init(request: Request, underlyingURLResponse: HTTPURLResponse?, data: Data? = nil, underlyingError: NSError? = nil ) {
        
        self.request               = request
        self.underlyingURLResponse = underlyingURLResponse
        self.data                  = data
        
        if let err = underlyingError {
            _error = APIError(underlyingError: err)
        }
    }
    
    
    /// Init a Response with an error. This is for when a response object is required, but an error occurs on the client side before an actual HTTP response can be obtained.
    
    init(error: APIError) {
        self.request = Request("error") // slightly hacky, but I don't want to make path optional right now FIXME do it bro
        self._error   = error
    }
    
    
    /// The originating `Request` instance, for which the receiver is a matched pair. The request has the details about what was requested and what the expectations were, while the result has the details of what actually came back from the sever (or what error occurred).
    
    let request: Request
    
    
    /// The underlying system response object (which exposes some details like HTTP headers, HTTP version, etc). This object should always be present upon success, but may be nil when some kind of error has occurred (or in automated testing scenarios).
    
    var underlyingURLResponse: HTTPURLResponse?
    
    
    /// The raw data received with the response (if any).
    
    var data: Data?
    
    
    /// Returns `self.data` as a UTF-8 string.
    
    var text: String? {
        guard let data = data else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    
    /// The actual HTTP status returned by the underlying HTTP request. May be nil, e.g. if error happened before HTTP response was received.
    
    var HTTPStatus: Int? {
        return underlyingURLResponse?.statusCode
    }
    
    
    /// Creates and returns a Payload object from the HTTP response from the API server, if it included a JSON payload that could be successfully parsed.
    
    var payload: Payload? {
        
        var result: Payload? = nil
        
        do {
            result = try Payload(data: data)
        } catch {
            result = nil
        }
        return result
        
        
        // Mason 2016-04-12: I was going to make this somewhat efficient (not parse the dictionary every time), but making this a "mutating get"
        // caused all sorts of hassle (any func in this struct using payload had to also be marked mutating, etc...) and I think it is not worth it.
        // (Unlike a class, a struct cannot modify a private property unless method is marked as mutating...) 
        //        mutating get {
        //            
        //            // Ah, "mutating get", my old nemesis... blecch
        //            
        //            if _payload != nil {
        //                return _payload
        //            }

    }
    
    
    /// An `error` value of `nil` indicates success. A non-nil value indicates an error has occured. Usually, an error will be returned by the API server, but other errors are possible. E.g., a client-side error accessing the network.
    
    var error: APIError? {
        
        guard _error == nil else {
            return _error
        }
        
        guard HTTPStatus == request.expectedHTTPStatus else {
            
            // The API reported an error. Let's see if we can parse this as a regular API error response, since that
            // will presumably yield a more informative error message. If not, just create a generic error here.
            // FIXME: See if we can add real err codes for client-side errs, that don't potentially conflict with API-side err codes.
            
            return APIError(payload: payload) ??
                   APIError(code: "CLI0666", message: "got HTTP status \(String(describing: HTTPStatus)), but expected \(request.expectedHTTPStatus)")
        }
        
        guard let data = data else {
            // If there's no data, there is no payload, so getting here means no error.
            return nil
        }
        
        do {
            let _ = try Payload(data: data)
        } catch {
            return APIError(code: "CLI0666", message: "could not decode response payload")
        }
        
        return nil
    }
    private var _error: APIError? = nil // can be set at init time, when client-side err occurs before networking
    
    
//    /// Internal func to check for missing keys and return an appropriate APIError if required keys are missing. Returns nil if no keys are missing. FIXME: Should be Payload's job, but that's not in yet.
//    
//    func getErrorIfExpectedKeysAreMissing() -> APIError? {
//        
//        var missingKeys: [String] = []
//        let dict = dictionary
//        
//        for key in request.expectedResponseKeys {
//            if dict?[key] == nil {
//                missingKeys.append(key)
//            }
//        }
//        if missingKeys.count > 0 {
//            return APIError(code:"CLI0667", message: "failed to parse response: missing data for \(missingKeys.joinWithSeparator(", "))" )
//        } else {
//            return nil
//        }
//    }
    // FIXME: the above is a busted-ass approach, but leaving a fossil here until I implement something cool (e.g., an optional validation closure that Request can specify, that will then be called on the resulting payload at response-processing time?)
    
}


extension Response: CustomStringConvertible {
    
    /// Return an attractive and understandable end-user-facing textual representations of the response. Intended for debugging and learning. (And maybe verbose logging?)

    public var description: String {
        let f = RequestResponseFormatter()
        return f.formatResponse(self)
    }
}
