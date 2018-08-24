// APIError.swift Created by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// APIError represents an error returned by the API, or (in a few limited cases) an error that occurred while attempting to interact with the API. 
///
/// (Despite having *Error* in its name, it is a data structure, not an ErrorType or relative of NSError.)

open class APIError: Decodable {
    
    /// The error code. In most cases, this is an error code returned by the API server. However, if the error code begins with "CLI" then it is a client-side error, e.g. something that prevented even getting a response from the server (such as, 'network not available').
    
    public let code: String
    
    
    /// The error messsage describing what went wrong.
    
    public let message: String
    
    
    /// A non-nil value indicates a client-side error (some error condition that happens on the client side, as opposed to being returned from the API server, e.g. 'network not available'.
    
    public let underlyingError: NSError?
    
    
    /// Init an error the normal way, for an error condition returned by the API server.
    
    public init(code: String?, message: String?) {
        self.code    = code ?? "UNK0001" // copy what Go SDK does
        self.message = message ?? "unknown error"
        // FIXME: Mason 2016-03-06: the Go SDK has one more field, messageArgs, which is used to compose the actual message string, but I haven't yet had time to make that work. (See: api_error.go)
        
        self.underlyingError = nil
    }
    
    
    /// Init an error for a local client-side error. Usually this would be the NSError reported by NSURLSession, e.g. network connection not available.
    
    public init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        
        // FIXME: Someday we should have more intelligent error codes and messages based on what the underlying error is.
        
        self.code    = "CLI0666"
        self.message = "A client side error occurred: \(underlyingError)"
    }
    
    
    /// Init a new APIError from JSON data. Returns nil unless `data` exists and has `.code` and `.message` keys.
    
    public static func from(jsonData: Data?) -> APIError? {
        
        guard let jsonData = jsonData else {
            return nil
        }
        
         var result: APIError? = nil
        
        do {
            result = try JSONDecoder().decode(self, from: jsonData)
        } catch let err {
            Metrics.record(type: .decodeFailure, description: self, error: err, data: jsonData)
        }
        return result
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(.code)
        message = try container.decode(.message)
        underlyingError = nil
        // FIXME: add messageArgs (see note above)
    }

    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }

}

// MARK: - CustomStringConvertible

extension APIError: CustomStringConvertible {
    
    public var description: String {
        return "\(type(of: self)): {code: \"\(code)\",  message: \"\(message)\"}"
    }
    
}

