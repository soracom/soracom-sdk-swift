//  SubscriberTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif

class SubscriberTests: BaseTestCase {
    
    func test_serialize() {
        let s  = Subscriber(ipAddress: "1.2.3.4", speedClass: "s1.fast", imsi: "8675309")
        
        guard let s2 = roundTripSerializeDeserialize(s) as? Subscriber else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(s2.speedClass, "s1.fast")
        XCTAssertEqual(s2.imsi,       "8675309")
    }
    
    
    func test_serialize_list() {
        
        let a  = Subscriber(ipAddress: "1.2.3.4", speedClass: "s1.fast", imsi: "8675309")
        let b  = Subscriber(ipAddress: "2.3.4.5", speedClass: "s1.fast", imsi: "8675310")
        let c  = Subscriber(ipAddress: "3.4.5.6", speedClass: "s1.fast", imsi: "8675311")
        

        
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
