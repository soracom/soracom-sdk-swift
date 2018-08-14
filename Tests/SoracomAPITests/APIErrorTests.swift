// APIErrorTests.swift Created by mason on 2016-04-10. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_MAC_DEMO_APP
    // Do nothing (it's magic). We unfortunately need 3 different import
    // modes: Xcode+macOS, Xcode+iOS, and non-Xcode ("swift test" CLI)
    // due to macOS and iOS not supporting SPM build/test...
#elseif USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomSDK
#else
    @testable import SoracomAPI 
#endif


class APIErrorTests: BaseTestCase {
    
    func test_APIError_existence() {
        
        let e = APIError(code: "WTF01234", message: "Hello, error!")
        XCTAssertTrue(e.code.contains("WTF"))
    }
    
    
    func test_APIError_init_with_payload() {
        
        let bad = ["email": "no error code", "message": "a message"].toData()
        let good = ["code": "no error code", "message": "a message"].toData()
        
        let e1 = APIError.from(jsonData: bad)
        let e2 = APIError.from(jsonData: nil)
        
        let e3 = APIError.from(jsonData: good)
        
        XCTAssertNil( e1 )
        XCTAssertNil( e2 )
        
        XCTAssertNotNil( e3)
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

