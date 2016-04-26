// Request+SandboxAPI.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


extension Request {
    
    /// Generate a sign-up token to activate a sandbox account. This is necessary to activate an account in the API Sandbox, and for this step (only) you need to use a real authKey and authKeyId for a SAM user in the non-sandbox production environment. See [this page](https://dev.soracom.io/jp/docs/api_sandbox/) for details. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Operator/getSignupToken)
    
    public class func getSignupToken(email email: String, authKeyId: String, authKey: String) -> Request {
        
        let req = self.init("/sandbox/operators/token/" + email)
        
        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
        
        req.requestPayload = [
            .authKeyId : authKeyId,
            .authKey   : authKey,
        ]
        
        req.expectedHTTPStatus   = 200
        req.expectedResponseKeys = ["token"]
        
        return req
    }
    
    
    /// Delete the operator specified by `operatorId`. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Operator/deleteSandboxOperator)
    
    public class func deleteSandboxOperator(operatorId: String) -> Request {
        
        let req = self.init("/sandbox/operators/" + operatorId)
        req.expectedHTTPStatus = 200
        req.method             = .DELETE
        return req
    }
 
    
    /// Create a sandbox subscriber (a fake SIM for testing). ([Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Subscriber/createSandboxSubscriber))
    
    public class func createSandboxSubscriber() -> Request {
        let req = self.init("/sandbox/subscribers/create")
        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
        return req
    }
    
    
    /// Insert Air stats for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Stats/insertAirStats)
    
    public class func insertAirStats(imsi: String, stats: AirStats) -> Request {
        
        // FIXME: Mason 2016-03-21: this isn't actually working yet; I always get a HTTP 500 with HTML error message as response:
        //    RangeError: Invalid time value<br> &nbsp;at Date.toISOString (native)<br> &nbsp;at isoFormat ...
        
        let req = self.init("/sandbox/stats/air/subscribers/" + imsi)
        
        req.expectedHTTPStatus = 200
        req.method = .POST

        req.requestPayload = stats.toPayload()

        return req
    }
    
    
    /// Insert Beam stats for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Stats/insertBeamStats)
    
    public class func insertBeamStats(imsi: String, stats: BeamStatsInsertion) -> Request {
    
        let req = self.init("/sandbox/stats/beam/subscribers/" + imsi)
        req.requestPayload = stats.toPayload()
        return req
    }
    
    
    /// Create a new coupon for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Coupon/createSandboxCoupon)
    
    public class func createSandboxCoupon(amount: Int, balance:Int, billItemName: String, couponCode: String, expiryYearMonth: String) -> Request {

        let req = self.init("/sandbox/coupons/create")
        
        req.requestPayload = [
            .amount          : amount,
            .balance         : balance,
            .billItemName    : billItemName,
            .couponCode      : couponCode,
            .expiryYearMonth : expiryYearMonth
        ]
        return req
    }
    
}
