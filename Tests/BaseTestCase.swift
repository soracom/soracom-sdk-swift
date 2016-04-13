// BaseTestCase.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest


/// A base class that implements some common conveniences/hacks for the project's tests. e.g. making async tests require less boilerplate.

class BaseTestCase: XCTestCase {
    
    func expect(description: String = #function) -> XCTestExpectation {
        print("EXPECT: \(description)")
        return expectationWithDescription(#function)
        
    }
    
    
    func confirm(timeout: NSTimeInterval = 10.0) {
        waitForExpectationsWithTimeout(timeout) { error in
            if let error = error {
                print( error.localizedDescription )
            }
        }
    }
    
// Mason 2016-04-12: FIXME: relocate this code somewhere down the chain. It doesn't need to be in the base class.
    
//    /// Convenience method to get a new dummy IMSI from the API sandbox, before running your actual tests. You still need to set up expectations in your main test method body. Example:
//    ///
//    ///     let expectation = expect()
//    ///
//    ///     withNewIMSI { (imsi) in
//    ///         // do your test here
//    ///     }
//    ///     confirm()
//
//    func withNewIMSI(handler: (imsi: String) -> ()) {
//        Request.createSandboxSubscriber().run { (result) in
//            XCTAssert(result.error == nil)
//            if let imsi = result["imsi"] as? String {
//                handler(imsi: imsi)
//            } else {
//                XCTFail("withNewIMSI() could not get new IMSI")
//            }
//        }
//    }

}
