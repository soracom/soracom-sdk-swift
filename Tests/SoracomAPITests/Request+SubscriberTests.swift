// Request+SubscriberAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif

class RequestSubscriberTests: BaseTestCase {
    
    // Mason 2016-06-09: There's not much actual testing here yet... see also RegisterSIMTests.
    
    func test_listSubscribers_URL_generation() {
        
        let r = Request.listSubscribers(tagName: "fooTag", tagValue: "fooValue", tagValueMatchMode: .exact, statusFilter: [.active, .terminated], speedClassFilter: [.s1_fast, .s1_minimum], limit: 5, lastEvaluatedKey: nil)
        
        let url = r.buildURL()
        
        let actual   = url.absoluteString
        let expected = "https://api-sandbox.soracom.io/v1/subscribers?limit=5&speed_class_filter=s1.fast%7Cs1.minimum&status_filter=active%7Cterminated&tag_name=fooTag&tag_value=fooValue&tag_value_match_mode=exact"
        
        // The buildURL() implementation builds the query string in a determinsistic order, so this test works.
        
        XCTAssertEqual(actual, expected)
    }
    
    
    func test_listSubscribers() {
        
        let r = Request.listSubscribers()

        beginAsyncSection()
        
        r.run { (response) in
            XCTAssertNil(response.error)
            let list = response.parse()
            XCTAssertNotNil(list)
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    
    func test_setImeiLock() {

        let response = Request.listSubscribers().wait()
        
        guard let list = response.parse() else {
            XCTFail("failed to parse subscribers")
            return
        }
        
        guard list.count > 0 else {
            return XCTFail("wtf no SIMs found")
        }
            
        let firstSIM = list[0]
        
        guard let imsi = firstSIM.imsi else {
            XCTFail("wtf no imsi")
            return
        }
        
        print(firstSIM.toData()?.utf8String ?? "no firstSIM data")
        let imei = "0123456789012345"
        let setResponse = Request.setImeiLock(imsi: imsi, imei: imei).wait()
        
        XCTAssertNil(setResponse.error)
        guard let lockedSIM = Subscriber.from(setResponse.data) else {
            XCTFail("decode failed")
            return
        }
        
        guard let imeiLock = lockedSIM.imeiLock else {
            XCTFail("SIM should have been IMEI locked")
            return
        }
        
        XCTAssertEqual(imeiLock.imei, imei)
        
        let unsetResponse = Request.unsetImeiLock(imsi: imsi).wait();
        
        guard let unlockedSIM = Subscriber.from(unsetResponse.data) else {
            XCTFail("decode failed")
            return
        }
        XCTAssertNil(unlockedSIM.imeiLock)
    }
    
}

#if os(Linux)
    extension RequestSubscriberTests {
        static var allTests : [(String, (RequestSubscriberTests) -> () throws -> Void)] {
            return [
                ("test_listSubscribers_URL_generation", test_listSubscribers_URL_generation),
                ("test_listSubscribers", test_listSubscribers),
                ("test_setImeiLock", test_setImeiLock)
            ]
        }
    }
#endif
