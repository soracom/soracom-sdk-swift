// BeamStatsTest.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
@testable import SoracomAPI
#endif

class BeamStatsTests: BaseTestCase {
    
    func test_serialization() {
        
        let s  = BeamStats(inHttp: 1, inMqtt: 2, inTcp: 3, inUdp: 4, outHttp: 5, outHttps: 6, outMqtt: 7, outMqtts: 8, outTcp: 9, outTcps: 10, outUdp: 11)
        
        guard let s2 = roundTripSerializeDeserialize(s) as? BeamStats else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(s2.inHttp,   1)
        XCTAssertEqual(s2.inMqtt,   2)
        XCTAssertEqual(s2.inTcp,    3)
        XCTAssertEqual(s2.inUdp,    4)
        XCTAssertEqual(s2.outHttp,  5)
        XCTAssertEqual(s2.outHttps, 6)
        XCTAssertEqual(s2.outMqtt,  7)
        XCTAssertEqual(s2.outMqtts, 8)
        XCTAssertEqual(s2.outTcp,   9)
        XCTAssertEqual(s2.outTcps,  10)
        XCTAssertEqual(s2.outUdp,   11)
    }

}

#if os(Linux)
    extension BeamStatsTests {
        static var allTests : [(String, (BeamStatsTests) -> () throws -> Void)] {
            return [
                ("test_serialization", test_serialization),
            ]
        }
    }
#endif 

