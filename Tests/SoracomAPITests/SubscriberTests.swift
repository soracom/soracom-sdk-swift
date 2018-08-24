//  SubscriberTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

@testable import SoracomAPI

class SubscriberTests: BaseTestCase {
    
    func test_serialize() {
        let s  = Subscriber(imsi: "8675309", ipAddress: "1.2.3.4", speedClass: "s1.fast", status:"ready")
        
        guard let s2 = roundTripSerializeDeserialize(s) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(s2.speedClass, "s1.fast")
        XCTAssertEqual(s2.imsi,       "8675309")
    }
    
    
    func test_serialize_list() {
        
        let a  = Subscriber(imsi: "8675309", ipAddress: "1.2.3.4", speedClass: "s1.fast", status:"ready")
        let b  = Subscriber(imsi: "8675310", ipAddress: "2.3.4.5", speedClass: "s1.fast", status:"ready")
        let c  = Subscriber(imsi: "8675311", ipAddress: "3.4.5.6", speedClass: "s1.fast", status:"ready")
        
        guard
            let incoming = roundTripSerializeDeserialize([a, b, c]),
            let data = incoming.toData(),
            let list = Subscriber.listFrom(data)
        else {
            XCTFail()
            return
        }
        
        guard list.count == 3 else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(list[0].imsi, "8675309")
        XCTAssertEqual(list[1].imsi, "8675310")
        XCTAssertEqual(list[2].imsi, "8675311")
    }
    
}

#if os(Linux)
    extension SubscriberTests {
        static var allTests : [(String, (SubscriberTests) -> () throws -> Void)] {
            return [
                ("test_serialize_list", test_serialize_list),
                ("test_serialize_list", test_serialize_list),
            ]
        }
    }
#endif
