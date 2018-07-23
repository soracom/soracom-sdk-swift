// ResponsePayloadTests.swift Created by mason on 2017-07-28. 

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
