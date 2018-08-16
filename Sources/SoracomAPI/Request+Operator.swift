// Request+Operator.swift Created by mason on 2016-04-14. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension Request where T == NoResponseBody {
    
    /// Register a new operator. In the sandbox environment, this is one of the first steps that needs to be done. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/createOperator))
    
    public class func createOperator(
        _ email: String,
        password: String,
        coverageTypes: [RegisterOperatorsRequest.CoverageTypes]? = nil,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
        ) -> Request<NoResponseBody> {
        
        let req = Request<NoResponseBody>.init("/operators", responseHandler: responseHandler)
        
        let requestObject = RegisterOperatorsRequest(email: email, password: password, coverageTypes: coverageTypes)
        if let coverageTypes = coverageTypes {
            requestObject.coverageTypes = coverageTypes
        }
        
        req.messageBody = requestObject.toData()
        
        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
        req.expectedHTTPStatus = 201
        
        return req
        
        // FIXME: This is old pre-codegen version.... now the above should call through to the primitive createOperator(request:) method
        
        // DISCUSSION
        //
        //    print(response)
        //    print(responseData)
        //    print(error)
        
        // 0.) RESPONSE IF IT WORKS:
        //        Optional(<NSHTTPURLResponse: 0x60000002b500> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 201, headers {...} })
        //    Optional("")
        //    nil
        
        // 1.) RESPONSE IF ALREADY REGISTERED:
        //        Optional(<NSHTTPURLResponse: 0x62000002bee0> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 400, headers {...} })
        //    Optional("{\"code\":\"AUM0003\",\"message\":\"This email is already registered.\"}")
        
        // NOTE: It seems to let me create the same user over and over. But it failed "already registered" when I used my previous credentials. So maybe it lets you create multiple times if the sandbox user being created has no records/activity associated with it?
    }
    
    /// Verify an operator. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/verifyOperator))
    
    public class func verifyOperator(token: String, responseHandler: ResponseHandler<NoResponseBody>? = nil) -> Request<NoResponseBody> {
        
        return verifyOperator(token: VerifyOperatorsRequest(token: token))
        
    }

}

extension Request where T == GetSignupTokenResponse {
    
    /// Generate a sign-up token to activate a sandbox account. This is necessary to activate an account in the API Sandbox, and for this step (only) you need to use a real authKey and authKeyId for a SAM user in the non-sandbox production environment. See [this page](https://dev.soracom.io/jp/docs/api_sandbox/) for details. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Operator/getSignupToken)
    
    public class func getSignupToken(
        email: String,
        authKeyId: String,
        authKey: String,
        responseHandler: ResponseHandler<GetSignupTokenResponse>? = nil
        ) -> Request<GetSignupTokenResponse> {
        
        return getSignupToken(auth: GetSignupTokenRequest(authKey: authKey, authKeyId: authKeyId), email: email, responseHandler: responseHandler)
    }
    
}

/// OLD PRE CODEGEN STUFF BELOW: FIXME: REVIEW/RELOCATE/DELETE

extension Request {
    
//    /// Register a new operator. In the sandbox environment, this is one of the first steps that needs to be done. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/createOperator))
//    
//    public class func createOperator(_ email: String, password: String, coverageTypes: [String]? = nil, responseHandler: ResponseHandler? = nil) -> Request {
//        
//        let req = self.init("/operators", responseHandler: responseHandler)
//        
//        let requestObject = RegisterOperatorsRequest(email: email, password: password, coverageTypes: coverageTypes)
//        if let coverageTypes = coverageTypes {
//            requestObject.coverageTypes = coverageTypes
//        }
//
//        req.messageBody = requestObject.toData()
//
//        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
//        req.expectedHTTPStatus = 201
//        
//        return req
//        
//        // DISCUSSION
//        //
//        //    print(response)
//        //    print(responseData)
//        //    print(error)
//        
//        // 0.) RESPONSE IF IT WORKS:
//        //        Optional(<NSHTTPURLResponse: 0x60000002b500> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 201, headers {...} })
//        //    Optional("")
//        //    nil
//        
//        // 1.) RESPONSE IF ALREADY REGISTERED:
//        //        Optional(<NSHTTPURLResponse: 0x62000002bee0> { URL: https://api-sandbox.soracom.io/v1/operators } { status code: 400, headers {...} })
//        //    Optional("{\"code\":\"AUM0003\",\"message\":\"This email is already registered.\"}")
//        
//        // NOTE: It seems to let me create the same user over and over. But it failed "already registered" when I used my previous credentials. So maybe it lets you create multiple times if the sandbox user being created has no records/activity associated with it?
//    }
    
    
//    /// Verify an operator. ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Operator/verifyOperator))
//
//    public class func verifyOperator(token: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req = self.init("/operators/verify", responseHandler: responseHandler)
//
//        req.messageBody = VerifyOperatorsRequest(token: token).toData()
//        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
//        return req
//    }
//
    
    
    
    
    // FIXME: RELOCATE:
    
    /// Add (agree to terms and sign up for) another coverage type to existing operator.
    
//    public class func addCoverageType(_ coverageType: CoverageType, operatorId: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req = self.init("/operators/\(operatorId)/coverage_type/\(coverageType.rawValue)/signup", responseHandler: responseHandler)
//
//        req.shouldSendAPIKeyAndTokenInHTTPHeaders = true
//        // no message body
//        return req
//    }

    

}
