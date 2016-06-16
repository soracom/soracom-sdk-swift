// Request+SubscriberAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestSubscriberTests: BaseTestCase {
    
    // Mason 2016-06-09: There's not much actual testing here yet... see also RegisterSIMTests.
    
    func test_listSubscribers_URL_generation() {
        
//        let r = Request.listSubscribers(tagName: "fooTag", tagValue: "fooValue", tagValueMatchMode: .exact, statusFilter: [.active, .terminated], speedClassFilter: [.s1_fast, .s1_minimum], limit: 5, lastEvaluatedKey: nil)
//        
//        let url = r.buildURL()
//        
//        let actual   = url.absoluteString
//        let expected = "https://api-sandbox.soracom.io/v1/subscribers?tag_value=fooValue&status_filter=active%7Cterminated&limit=5&tag_value_match_mode=exact&speed_class_filter=s1.fast%7Cs1.minimum&tag_name=fooTag"
//        
//        XCTAssertEqual(actual, expected)
        
        // Ooops! This test doesn't make sense... the order that keys are iterated to build the query string is arbitrary. This just happened to work for a while.
        // FIXME: update either this test, or the tested implementation, to make a test happen
    }
    
    
    func test_listSubscribers() {
        
        let r = Request.listSubscribers()

        beginAsyncSection()
        
        r.run { (response) in
            XCTAssertNil(response.error)
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
}