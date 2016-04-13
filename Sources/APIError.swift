// APIError.swift Created by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// APIError represents an error returned by the API, or (in a few limited cases) an error that occurred while attempting to interact with the API. 
///
/// (Despite having *Error* in its name, it is a data structure, not an ErrorType or relative of NSError.)

public struct APIError {
    
    /// The error code. In most cases, this is an error code returned by the API server. However, if the error code begins with "CLI" then it is a client-side error, e.g. something that prevented even getting a response from the server (such as, 'network not available').
    
    let errorCode: String
    
    
    /// The error messsage describing what went wrong.
    
    let message: String
    
    
    /// A non-nil value indicates a client-side error (some error condition that happens on the client side, as opposed to being returned from the API server, e.g. 'network not available'.
    
    let underlyingError: NSError?
    
    
    /// Init an error the normal way, for an error condition returned by the API server.
    
    init(errorCode: String?, message: String?) {
        self.errorCode = errorCode ?? "UNK0001" // copy what Go SDK does
        self.message   = message ?? "unknown error"
        // FIXME: Mason 2016-03-06: the Go SDK has one more field, messageArgs, which is used to compose the actual message string, but I haven't yet had time to make that work. (See: api_error.go)
        
        self.underlyingError = nil
    }
    
    
    /// Init an error for a local client-side error. Usually this would be the NSError reported by NSURLSession, e.g. network connection not available.
    
    init(underlyingError: NSError) {
        self.underlyingError = underlyingError
        
        // FIXME: Someday we should have more intelligent error codes and messages based on what the underlying error is.
        
        self.errorCode = "CLI0666"
        self.message   = "A client side error occurred: \(underlyingError)"
    }

}
