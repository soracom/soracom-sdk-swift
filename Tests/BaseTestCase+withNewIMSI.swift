// BaseTestCase+withNewIMSI.swift Created by mason on 2016-04-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

extension BaseTestCase {
    
    /// Convenience method to get a new dummy IMSI from the API sandbox, before running your actual tests. You still need to set up expectations in your main test method body. Example:
    ///
    ///     let expectation = beginAsyncSection()
    ///
    ///     withNewIMSI { (imsi) in
    ///         // do your test here
    ///         self.endAsyncSection()
    ///     }
    ///     waitForAsyncSection()

    func withNewIMSI(handler: (imsi: String) -> ()) {
        Request.createSandboxSubscriber().run { (response) in
            XCTAssert(response.error == nil)
            if let imsi = response.payload?[.imsi] as? String {
                handler(imsi: imsi)
            } else {
                XCTFail("withNewIMSI() could not get new IMSI")
            }
        }
    }
    
}


