// ResponseTests.swift Created by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class ResponseTests: XCTestCase {
    
    var request: Request = Request("/foo")
    
    var dummyURL: NSURL { return request.buildURL() }
    
    var badResponse: NSHTTPURLResponse? {
        return NSHTTPURLResponse(URL: dummyURL, statusCode: 500, HTTPVersion: "1.1", headerFields: nil)
    }
    var goodResponse: NSHTTPURLResponse? {
        return NSHTTPURLResponse(URL: dummyURL, statusCode: 200, HTTPVersion: "1.1", headerFields: nil)
    }
    
    
    func test_expected_keys_are_missing_error() {

        request.expectedResponseKeys = ["email", "couponCode", "userName"]
        
        let goodPayload: Payload = [
            PayloadKey.email      : "foo@bar.baz",
            PayloadKey.couponCode : "12345",
            PayloadKey.userName   : "asshat"
        ]
        
        let badPayload: Payload = [
            PayloadKey.email        : "foo@bar.baz",
            PayloadKey.description  : "12345",
            PayloadKey.billItemName : "It's Miller® Time™!"
        ]
        
        let goodData = goodPayload.toJSONData()
        let badData  = badPayload.toJSONData()

        let good = Response(request: request, underlyingURLResponse: goodResponse, data: goodData)
        let bad  = Response(request: request, underlyingURLResponse: goodResponse, data: badData)
        
        XCTAssert(good.error == nil)
        
        XCTAssert(bad.error != nil)
        
        if let msg = bad.error?.message {
            XCTAssert(msg.containsString("userName"))
            XCTAssert(msg.containsString("couponCode"))
            // because the message should list the missing keys
        } else {
            XCTFail("bad.error should have had a message")
        }
    }
    
    
    func test_unexpected_HTTP_status_error() {

        let result1 = Response(request: request, underlyingURLResponse: badResponse)
        XCTAssert(result1.error != nil)
        
        let result2 = Response(request: request, underlyingURLResponse: goodResponse)
        XCTAssert(result2.error == nil)
    }

}
