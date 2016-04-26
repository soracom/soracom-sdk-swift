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
    
    init(request: Request, underlyingURLResponse: NSHTTPURLResponse?, data: NSData? = nil) {
        
        self.request               = request
        self.underlyingURLResponse = underlyingURLResponse
        self.data                  = data
        
        error = getErrorIfHTTPStatusIsUnexpected() ?? getErrorIfExpectedKeysAreMissing()
          // Mason 2016-03-12: This is bad design; it checks before necessary and it impairs testability. FIXME: Make APIError a computed property or something.
    }
    
    
    /// The originating `Request` instance, for which the receiver is a matched pair. The request has the details about what was requested and what the expectations were, while the result has the details of what actually came back from the sever (or what error occurred).
    
    let request: Request
    
    
    /// The underlying system response object (which exposes some details like HTTP headers, HTTP version, etc). This object should always be present upon success, but may be nil when some kind of error has occurred (or in automated testing scenarios).
    
    var underlyingURLResponse: NSHTTPURLResponse?
    
    
    /// The raw data received with the response (if any).
    
    var data: NSData?
    
    
    /// Returns `self.data` as a UTF-8 string.
    
    var text: String? {
        guard let data = data else {
            return nil
        }
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    
    
    /// Parses `self.data` as JSON, and returns it in native dictionary format. Returns nil if JSON parsing fails, or JSON → dictionary deserialization fails.
    
    var dictionary: [String:AnyObject]? {
        
        guard let data = data else {
            return nil
        }
        
        guard data.length > 0 else {
            return nil
        }
        
        var result: [String:AnyObject]? = nil
        
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let dict = dict as? [String:AnyObject] {
                result = dict
            }
        } catch {
            print ("JSON deserialization of received data failed: \(error)")
            
            // Mason 2016-03-21: Note: sometimes, the server returns error message as HTML (with HTTP status 500)
            // e.g.:
            // Data (as UTF-8): 【RangeError: Invalid time value<br> &nbsp;at Date.toISOString (native)<br> &nbsp;at isoFormat... (continues)
            //
            // FIXME: We should capture that and use it.
        }
        
        return result
    }
    
    
    /// The actual HTTP status returned by the underlying HTTP request. May be nil, e.g. if error happened before HTTP response was received.
    
    var HTTPStatus: Int? {
        return underlyingURLResponse?.statusCode
    }
    
    
    /// After receipt and successful decoding of the response from the API server, if the response included a JSON payload, it can be accessed via this property (as a Payload instance).
    
    var payload: Payload? {
        
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

        guard let dict = dictionary else {
            return nil
        }
        
        do {
            return try Payload.fromDictionary(dict)
        } catch {
            print("\(#function)Got an error constructing a Payload instance from this received data:")
            print(text)
            print("For now, PayloadError is 'under study' and not yet nailed-down, so here we just ignore the error and return nil.")
            return nil
        }
        
    }
    
    
    /// If an error occurs, it will be stored in this property. Usually, an error will be returned by the API server, but other errors are possible. E.g., a client-side error accessing the network. And `error` value of `nil` indicates success.
    
    var error: APIError?
    
    
    /// Internal func to compare the actual `HTTPStatus` with the `expectedHTTPStatus`, and construct and return an appropriate `APIError` if they don't match. Returns nil if `HTTPStatus == expectedHTTPStatus`.
    
    func getErrorIfHTTPStatusIsUnexpected() -> APIError? {
        
        guard HTTPStatus != request.expectedHTTPStatus else {
            return nil
        }
        
        // The API reported an error. Let's see if we can parse this as a regular API error response:
        
        if let error = APIError(payload: payload) {
            return error
        } else {
            // Hmm. The server didn't return the [code:, message:] err result that we understand, so make a generic error instead:
            return APIError(code: "CLI0666", message: "got HTTP status \(HTTPStatus), but expected \(request.expectedHTTPStatus)")
            // FIXME: See if we can add real err codes for client-side errs, that don't potentially conflict with API-side err codes.
        }
    }
    
    /// Internal func to check for missing keys and return an appropriate APIError if required keys are missing. Returns nil if no keys are missing. FIXME: Should be Payload's job, but that's not in yet.
    
    func getErrorIfExpectedKeysAreMissing() -> APIError? {
        
        var missingKeys: [String] = []
        let dict = dictionary
        
        for key in request.expectedResponseKeys {
            if dict?[key] == nil {
                missingKeys.append(key)
            }
        }
        if missingKeys.count > 0 {
            return APIError(code:"CLI0667", message: "failed to parse response: missing data for \(missingKeys.joinWithSeparator(", "))" )
        } else {
            return nil
        }
    }
    
}


extension Response: CustomStringConvertible {
    
    /// Return an attractive and understandable end-user-facing textual representations of the response. Intended for debugging and learning. (And maybe verbose logging?)

    public var description: String {
        let f = RequestResponseFormatter()
        return f.formatResponse(self)
    }

}
