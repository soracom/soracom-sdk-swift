// APIErrorTests.swift Created by mason on 2016-04-10. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
@testable import SoracomAPI
#endif

class APIErrorTests: BaseTestCase {
    
    func test_APIError_existence() {
        
        let e = APIError(code: "WTF01234", message: "Hello, error!")
        XCTAssertTrue(e.code.contains("WTF"))
    }
    
    
    func test_APIError_init_with_payload() {
        
        let bad: Payload  = [.email: "no error code", .message: "a message"]
        let good: Payload = [.code: "no error code", .message: "a message"]
        
        XCTAssertNil(APIError(payload: bad))
        XCTAssertNil(APIError(payload: nil))
        
        XCTAssertNotNil(APIError(payload:good))
    }
    
}

#if os(Linux)
    extension APIErrorTests {
        static var allTests : [(String, (APIErrorTests) -> () throws -> Void)] {
            return [
                ("test_APIError_existence", test_APIError_existence),
                ("test_APIError_init_with_payload", test_APIError_init_with_payload),
            ]
        }
    }
#endif 

