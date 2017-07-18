// SerializationTests.swift Created by mason on 2017-07-18. Copyright © 2017 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif


class SerializationTests: BaseTestCase {
    
    func test_serialize_AuthResponse() {
        
        let ar1 = AuthResponse(
            apiKey:     "just the good ol' boys",
            token:      "never meanin' no harm",
            operatorId: "beats all you never saw, been in trouble with the law",
            userName:   "since the day they was born"
        )
        
        guard let ar2  = roundTripSerializeDeserialize(ar1) as? AuthResponse else {
            XCTFail()
            return
        }
        XCTAssertEqual(ar2.apiKey,     "just the good ol' boys")
        XCTAssertEqual(ar2.token,      "never meanin' no harm")
        XCTAssertEqual(ar2.operatorId, "beats all you never saw, been in trouble with the law")
        XCTAssertEqual(ar2.userName,   "since the day they was born")
    }

}

#if os(Linux)
    extension SerializationTests {
        static var allTests : [(String, (SerializationTests) -> () throws -> Void)] {
            return [
                ("test_serialize_AuthResponse", test_serialize_AuthResponse),
            ]
        }
    }
#endif
