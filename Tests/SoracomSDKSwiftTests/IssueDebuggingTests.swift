// IssueDebuggingTests.swift Created by Mason Mark on 7/29/16. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest


/// These are not really tests of this SDK, they are test cases that use this SDK to help debug issues in various other projects that use the Soracom API. (But using this SDK for that purpose may result in improvements or bug fixes to it as well.)

class IssueDebuggingTests: BaseTestCase {
    
    func test_bro() {
    
        // https://api-sandbox.soracom.io/v1/groups/c8726c12-75f2-47db-8ecb-ee35d6e9ee66/subscribers?status_filter=suspended&limit=10
        
        let req = Request.listSubscribersInGroup("c8726c12-75f2-47db-8ecb-ee35d6e9ee66")
        
        req.query = Request.makeQueryDictionary(statusFilter: [.inactive])
        let res = req.wait();
        
        let subscribers = Subscriber.listFrom(res.payload)
        
        print(req)
        print(res)
        print(subscribers ?? "subscribers == nil")
        print("subscribers count is \(String(describing: subscribers?.count))")
        
        print("w00t?")
    }
}
