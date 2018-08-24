// TagUpdateRequestTests.swift Created by Mason Mark on 2018-08-21. Copyright © 2018 Soracom, Inc. All rights reserved.

import XCTest

@testable import SoracomAPI

class TagUpdateRequestTests: XCTestCase {
    
    func test_convenience_initializers() {
        
        let foo: TagUpdateRequest = ["key1": "value1"]
        XCTAssert(foo.tagName == "key1")
        XCTAssert(foo.tagValue == "value1")
        
        let bar: [TagUpdateRequest] = ["key2": "value2", "key3": "value3"]
        XCTAssert(bar[0].tagName == "key2")
        XCTAssert(bar[0].tagValue == "value2")
        XCTAssert(bar[1].tagName == "key3")
        XCTAssert(bar[1].tagValue == "value3")
    }
}

#if os(Linux)
extension TagUpdateRequestTests {
    static var allTests : [(String, (TagUpdateRequestTests) -> () throws -> Void)] {
        return [
            ("test_convenience_initializers", test_convenience_initializers),
        ]
    }
}
#endif

