// Request+Credentials.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request {
    
    /// Returns the list of stored credentials. [API docs](https://dev.soracom.io/en/docs/api/#!/Credential/listCredentials)
    
    public class func listCredentials(_ responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/credentials", responseHandler: responseHandler)
        req.method = .GET
        return req
    }
    

    /// Deletes a credential. [API docs](https://dev.soracom.io/en/docs/api/#!/Credential/deleteCredential)
    
    public class func deleteCredential(id: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let safeComponent = id.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let req = self.init("/credentials/" + (safeComponent ?? ""), responseHandler: responseHandler)
          // FIXME: blank component will cause error, but we should fail better here
        
        req.expectedHTTPStatus = 204
        req.method             = .DELETE
        return req
    }
    
    
    /// Creates a new credential. [API docs](https://dev.soracom.io/en/docs/api/#!/Credential/createCredential)
    
    public class func createCredential(id: String, options: CredentialOptions, responseHandler: ResponseHandler? = nil) -> Request {
        
        let safeComponent = id.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let req = self.init("/credentials/" + (safeComponent ?? ""), responseHandler: responseHandler)
          // FIXME: blank component will cause error, but we should fail better here
        
        req.expectedHTTPStatus = 201
        req.method             = .POST
        req.payload            = options.toPayload()
        return req
    }
    
    
    /// Updates a credential. [API docs](https://dev.soracom.io/en/docs/api/#!/Credential/updateCredential)
    
    public class func updateCredential(id: String, options: CredentialOptions, responseHandler: ResponseHandler? = nil) -> Request {
        
        let safeComponent = id.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let req = self.init("/credentials/" + (safeComponent ?? ""), responseHandler: responseHandler)
          // FIXME: blank component will cause error, but we should fail better here
        
        req.expectedHTTPStatus = 200
        req.method             = .PUT
        req.payload            = options.toPayload()
        return req
    }
    
}
