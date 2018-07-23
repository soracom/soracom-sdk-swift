// ResponseTests.swift Created by mason on 2016-03-06. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
@testable import SoracomAPI
#endif

class ResponseTests: XCTestCase {
    
    var request: Request = Request("/foo")
    
    var dummyURL: URL { return request.buildURL() as URL }
    
    var badResponse: HTTPURLResponse? {
        return HTTPURLResponse(url: dummyURL, statusCode: 500, httpVersion: "1.1", headerFields: nil)
    }
    var goodResponse: HTTPURLResponse? {
        return HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: "1.1", headerFields: nil)
    }
    
    
    func test_unexpected_HTTP_status_error() {

        let result1 = Response(request: request, underlyingURLResponse: badResponse)
        XCTAssert(result1.error != nil)
        
        let result2 = Response(request: request, underlyingURLResponse: goodResponse)
        XCTAssert(result2.error == nil)
    }

}

#if os(Linux)
    extension ResponseTests {
        static var allTests : [(String, (ResponseTests) -> () throws -> Void)] {
            return [
                ("test_unexpected_HTTP_status_error", test_unexpected_HTTP_status_error),
            ]
        }
    }
#endif
