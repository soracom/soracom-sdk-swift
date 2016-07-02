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
    
    
    func test_unexpected_HTTP_status_error() {

        let result1 = Response(request: request, underlyingURLResponse: badResponse)
        XCTAssert(result1.error != nil)
        
        let result2 = Response(request: request, underlyingURLResponse: goodResponse)
        XCTAssert(result2.error == nil)
    }

}
