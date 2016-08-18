//  SubscriberTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class SubscriberTests: BaseTestCase {
    
    func test_serialize() {
        let s  = Subscriber(imsi: "8675309", speedClass: "s1.fast")
        
        guard let s2 = roundTripSerializeDeserialize(s) as? Subscriber else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(s2.speedClass, "s1.fast")
        XCTAssertEqual(s2.imsi,       "8675309")
    }
    
    
    func test_serialize_list() {
        
        let a  = Subscriber(imsi: "8675309", speedClass: "s1.fast")
        let b  = Subscriber(imsi: "8675310", speedClass: "s1.fast")
        let c  = Subscriber(imsi: "8675311", speedClass: "s1.fast")
        

        
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
        
        XCTAssertEqual(list[0].imsi, "8675309")
        XCTAssertEqual(list[1].imsi, "8675310")
        XCTAssertEqual(list[2].imsi, "8675311")
        
        print("wtf")
        
    }
    
}
