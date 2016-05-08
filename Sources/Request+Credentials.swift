// Request+Credentials.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

// NOTE: GIVING UP ON THIS FOR NOW (Mason 2016-03-23)
// I was doing the API in the order it is presented in the API Guide, but I am seeing errors from this section of the API,
// which look like this:
//
//            Response {
//                HTTP status:  500
//                In response to: GET https://api-sandbox.soracom.io/v1/credentials
//                HTTP headers: {
//                    Content-Type: text/plain; charset=utf-8
//                    Content-Length: 46
//                    Connection: keep-alive
//                    Date: Wed, 23 Mar 2016 05:11:43 GMT
//                }
//                Data (as UTF-8): 【{"code":"AGW0005", "message":"Internal error"}】
//            }
//
// I am not sure if I am Doing It Wrong, or if credentials is not something that works in the sandbox, or what, but anyway
// it is not very germane to the March 2016 demo and progress report to Soracom, so I am deferring this.


extension Request {
    
    
    /// FIXME: description forthcoming [API docs](https://dev.soracom.io/jp/docs/api/#!/Credential/listCredentials)
    
    public class func listCredentials(responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/credentials", responseHandler: responseHandler)
        req.method = .GET
        return req
    }
    
    
    /// FIXME: description forthcoming [API docs](https://dev.soracom.io/jp/docs/api/#!/Credential/createCredential)
    
    public class func createCredential(credentials: Credential, responseHandler: ResponseHandler? = nil) -> Request {
        
        let safeComponent = credentials.credentialsId.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        let req = self.init("/credentials/" + (safeComponent ?? ""), responseHandler: responseHandler)
        // FIXME: blank component will cause error, but we should fail better here
        
        req.expectedHTTPStatus = 201
        
        req.requestPayload = credentials.toPayload()
        
        return req
    }
}
