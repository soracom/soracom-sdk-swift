// APIStructuresTests.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif

class APIStructuresTests: BaseTestCase {
    
    func test_AirStats_serialization() {
        
        let fast  = DataTrafficStats(uploadBytes: 5, uploadPackets: 55, downloadBytes: 555, downloadPackets: 5555)
                let stats = AirStats(traffic: [.s1_fast: fast], unixtime: 8675309)
        
        let subsub: Payload = [
            .downloadByteSizeTotal: 555,
            .downloadPacketSizeTotal: 5555,
            .uploadByteSizeTotal: 5,
            .uploadPacketSizeTotal: 55,
        ]
        
        let sub: Payload = [
            PayloadKey.s1_fast : subsub
        ]
        
        print(stats.toPayload())
        
        let expected: Payload = [
            .unixtime            : 8675309,
            .dataTrafficStatsMap : sub
        ]
        
        let actual = stats.toPayload()
        
        guard let d1 = actual.toDictionary(), let d2 = expected.toDictionary() else {
            XCTFail()
            return
        }
        
        print(d1);
        print(d2);
        
        guard let actualJSON   = actual.toJSON(),
              let expectedJSON = expected.toJSON()
        else {
            XCTFail("didnt get JSON from payloads")
            return
        }
        
        XCTAssert(isEquivalentJSON(actualJSON, expectedJSON))
        
        XCTAssertEqual(NSDictionary(dictionary: d1), NSDictionary(dictionary: d2))
            // Hey, this now also works on Linux! (Mason 2017-07-14)
    }
    
 
    func test_credential_roundtrip_JSON_serialization() {
        
        // This test predates our serialization testing convenience methods.
        
        var foo = Credential()
        foo.createDateTime   = 666
        foo.credentials      = Credentials(accessKeyId: "access key bro", secretAccessKey: "secret bro")
        foo.credentialsId    = "credentials ID bro"
        foo.description      = "description bro"
        foo.lastUsedDateTime = 666
        foo.type             = "type bro"
        foo.updateDateTime   = 666
        
        guard let encoded = foo.toPayload().toJSON()?.data(using: String.Encoding.utf8) else {
            XCTFail()
            return
        }
        
        guard let payload = try? Payload(data: encoded),  let decoded = Credential.from(payload) else {
            XCTFail()
            return
        }
        
        XCTAssert(decoded.createDateTime == 666)
        XCTAssert(decoded.credentials?.accessKeyId == "access key bro")
        XCTAssert(decoded.credentials?.secretAccessKey == "secret bro")
        XCTAssert(decoded.description == "description bro")
        XCTAssert(decoded.lastUsedDateTime == 666)
        XCTAssert(decoded.type == "type bro")
        XCTAssert(decoded.updateDateTime == 666)
    }
    
    
    func test_AuthResponse_init() {
        let good: Payload = [
            .apiKey     : "some key",
            .token      : "some token value",
            .operatorId : "OP666",
        ]
        
        let bad: Payload = [
            .token      : "some token value",
            .operatorId : "OP666",
        ]
        
        let bogus = AuthResponse.from(bad)
        
        XCTAssertNil( bogus )
        
        let a = AuthResponse.from(good)
        
        XCTAssertNotNil(a)
    }
    
}


#if os(Linux)
    extension APIStructuresTests {
        static var allTests : [(String, (APIStructuresTests) -> () throws -> Void)] {
            return [
                ("test_AirStats_serialization", test_AirStats_serialization),
                ("test_credential_roundtrip_JSON_serialization", test_credential_roundtrip_JSON_serialization),
                ("test_AuthResponse_init", test_AuthResponse_init),
            ]
        }
    }
#endif 


