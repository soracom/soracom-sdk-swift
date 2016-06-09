// Request+SubscriberAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestSubscriberTests: BaseTestCase {
    
    // Mason 2016-06-09: There's not much actual testing here yet... see also RegisterSIMTests.
    
    func test_listSubscribers_URL_generation() {
        
        let r = Request.listSubscribers(tagName: "fooTag", tagValue: "fooValue", tagValueMatchMode: .exact, statusFilter: [.active, .terminated], speedClassFilter: [.s1_fast, .s1_minimum], limit: 5, lastEvaluatedKey: nil)
        
        let url = r.buildURL()
        
        XCTAssertEqual(url.absoluteString, "https://api-sandbox.soracom.io/v1/subscribers?tag_value=fooValue&status_filter=active%7Cterminated&limit=5&tag_value_match_mode=exact&speed_class_filter=s1.fast%7Cs1.minimum&tag_name=fooTag")
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