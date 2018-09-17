// ListOrdersTests.swift Created by Mason Mark on 2018-08-14. Copyright © 2018 Soracom, Inc. All rights reserved.


import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif


class ListOrdersTests: BaseTestCase {
    
    func test_listOrders() {
        
        let req = Request.listOrders()
        let res = req.wait()
        guard let obj = res.parse() else {
            XCTFail("couldn't parse response")
            return
        }
        guard let d = obj.toData() else {
            XCTFail()
            return
        }
        guard let e = ListOrderResponse.from(d) else {
            XCTFail()
            return
        }
        print(e)
    }
}


#if os(Linux)
extension ListOrdersTests {
    static var allTests : [(String, (ListOrdersTests) -> () throws -> Void)] {
        return [
            ("test_listOrders", test_listOrders),
        ]
    }
}
#endif

