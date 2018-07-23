// Request+SubscriberAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

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
            let list = Subscriber.listFrom(response.payload)
            XCTAssertNotNil(list)
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
}

#if os(Linux)
    extension RequestSubscriberTests {
        static var allTests : [(String, (RequestSubscriberTests) -> () throws -> Void)] {
            return [
                ("test_listSubscribers_URL_generation", test_listSubscribers_URL_generation),
                ("test_listSubscribers", test_listSubscribers),
            ]
        }
    }
#endif
