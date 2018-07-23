// NSDate+SoracomAPITests.swift Created by mason on 2016-06-24. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
@testable import SoracomAPI
#endif

class NSDateSoracomAPITests: XCTestCase {
    
    let birthday: Int64 = 147571200000 // ♬ happy birthday to me...

    func test_conversions() {
        
        let bday = Date(soracomTimestamp: birthday)
        
        let expected = "1974-09-05 00:00:00 +0000"
        let actual   = bday.description
        XCTAssertEqual(expected, actual)
          // relying on NSDate implementation detail, but they'd be nuts to change it
        
        let timestamp = bday.soracomTimestampValue
        XCTAssert(timestamp == birthday)
    }
}

#if os(Linux)
    extension NSDateSoracomAPITests {
        static var allTests : [(String, (NSDateSoracomAPITests) -> () throws -> Void)] {
            return [
                ("test_conversions", test_conversions),
            ]
        }
    }
#endif 

