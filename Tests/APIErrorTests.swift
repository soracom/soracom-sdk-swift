// APIErrorTests.swift Created by mason on 2016-04-10. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class APIErrorTests: XCTestCase {
    
    func test_APIError_existence() {
        
        let e = APIError(errorCode: "WTF01234", message: "Hello, error!")
        XCTAssertTrue(e.errorCode.containsString("WTF"))
    }
    
}
