// Request+Operator.swift Created by mason on 2016-04-14. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request {
    
    /// [API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/createOperator)
    
    public class func createOperator(email: String, password: String) -> Request {
        
        /// This request does not require credentials (in the sandbox, at least...)
        
        let req = self.init("/operators")
        req.expectedHTTPStatus = 201

        req.requestPayload = [
            .email    : email,
            .password : password,
        ]
        
        return req
    }
    
    
    

}