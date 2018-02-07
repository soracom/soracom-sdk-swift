// ResponsePayloadTests.swift Created by mason on 2017-07-28. 

import XCTest

@testable import SoracomAPI

class ResponsePayloadTests: BaseTestCase {
    
    
    func test_decode_subscriber_list() {
        
        let data = Fixtures.Data.subscribers
        
        do {
            let payload = try Payload(data: data)
            
            guard let list: SubscriberList = Subscriber.listFrom(payload) else {
                XCTFail("could not decode subscriber list")
                return
            }
            
            guard list.count == 2 else {
                XCTFail()
                return
            }
            
            let sub1 = list[0]
            let sub2 = list[1]
            
            XCTAssert(sub1.speedClass == SpeedClass.s1_fast.rawValue)
            XCTAssert(sub2.speedClass == SpeedClass.s1_slow.rawValue)
            
        } catch {
            XCTFail("payload init from data failed")
        }
    }
}



#if os(Linux)
    extension ResponsePayloadTests {
        
        static var allTests : [(String, (ResponsePayloadTests) -> () throws -> Void)] {
            return [
                ("test_decode_subscriber_list", test_decode_subscriber_list),
            ]
        }
    }
#endif
