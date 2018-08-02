// IssueDebuggingTests.swift Created by Mason Mark on 7/29/16. Copyright © 2016 Soracom, Inc. All rights reserved.

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

/// These are not really tests of this SDK, they are test cases that use this SDK to help debug issues in various other projects that use the Soracom API. (But using this SDK for that purpose may result in improvements or bug fixes to it as well.)

class IssueDebuggingTests: BaseTestCase {
    
    func test_bro() {
    
        // https://api-sandbox.soracom.io/v1/groups/c8726c12-75f2-47db-8ecb-ee35d6e9ee66/subscribers?status_filter=suspended&limit=10
        
        let req = Request.listSubscribersInGroup(groupId: "c8726c12-75f2-47db-8ecb-ee35d6e9ee66") // HOI
        
        let qd = ["statusFilter": [SubscriberStatus.inactive]]
        
        req.query = BaseRequest.makeQueryDictionary(qd)
        let res = req.wait();
        
        let subscribers = Subscriber.listFrom(res.payload)
        
        print(req)
        print(res)
        print(subscribers ?? "subscribers == nil")
        print("subscribers count is \(String(describing: subscribers?.count))")
        
        print("w00t?")
    }
}

#if os(Linux)
    extension IssueDebuggingTests {
        static var allTests : [(String, (IssueDebuggingTests) -> () throws -> Void)] {
            return [
                ("test_bro", test_bro),
            ]
        }
    }
#endif 

