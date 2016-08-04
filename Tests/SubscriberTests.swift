//  SubscriberTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class SubscriberTests: BaseTestCase {
    
    func test_serialize() {
        let s  = Subscriber(ipAddress: "187.187.187.187", speedClass: "s1.fast", imsi: "8675309")
        
        guard let s2 = roundTripSerializeDeserialize(s) as? Subscriber else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(s2.ipAddress,  "187.187.187.187")
        XCTAssertEqual(s2.speedClass, "s1.fast")
        XCTAssertEqual(s2.imsi,       "8675309")
    }
    
    
    func test_serialize_list() {
        
        let a  = Subscriber(ipAddress: "1.1.1.1", speedClass: "s1.fast", imsi: "8675309")
        let b  = Subscriber(ipAddress: "2.2.2.2", speedClass: "s1.fast", imsi: "8675309")
        let c  = Subscriber(ipAddress: "3.3.3.3", speedClass: "s1.fast", imsi: "8675309")
        
        let outgoing = Payload(list: [a,b,c])
        
        guard let incoming = roundTripSerializeDeserialize(outgoing),
              let list = Subscriber.listFrom(incoming.toPayload())
        else {
            XCTFail()
            return
        }
        
        guard list.count == 3 else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(list[0].ipAddress, "1.1.1.1")
        XCTAssertEqual(list[1].ipAddress, "2.2.2.2")
        XCTAssertEqual(list[2].ipAddress, "3.3.3.3")
        
        print("wtf")
        
    }
    
}
