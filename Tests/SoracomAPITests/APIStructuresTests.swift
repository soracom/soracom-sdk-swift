// APIStructuresTests.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif

class APIStructuresTests: BaseTestCase {
    
    func OFF_test_AirStats_serialization() {
        
        XCTFail("this test needs total rewrite")
//
//        // This old test predates Swift 4 and JSON support, which is why it is kind of funky...
//
//        let fast  = DataTrafficStats(downloadByteSizeTotal: 5, downloadPacketSizeTotal: 55, uploadByteSizeTotal: 555, uploadPacketSizeTotal: 5555)
//        let map   = DataTrafficStatsMap(s1_fast: fast, s1_minimum: nil, s1_slow: nil, s1_standard: nil)
//        let stats = AirStats(dataTrafficStatsMap: map, unixtime: 8675309)
//
//        let subsub = [
//            ."downloadByteSizeTotal": 5,
//            ."downloadPacketSizeTotal": 55,
//            ."uploadByteSizeTotal": 555,
//            .uploadPacketSizeTotal: 5555,
//        ]
//
//        let sub: Payload = [
//            PayloadKey.s1_fast : subsub
//        ]
//
//        print(stats.toPayload())
//
//        let expected: Payload = [
//            .unixtime            : 8675309,
//            .dataTrafficStatsMap : sub
//        ]
//
//        let actual = stats.toPayload()
//
//        guard let d1 = actual.toDictionary(), let d2 = expected.toDictionary() else {
//            XCTFail()
//            return
//        }
//
//        print(d1);
//        print(d2);
//
//        guard let actualJSON   = actual.toJSON(),
//              let expectedJSON = expected.toJSON()
//        else {
//            XCTFail("didnt get JSON from payloads")
//            return
//        }
//
//        let isEquivalent = isEquivalentJSON(actualJSON, expectedJSON)
//        XCTAssert(isEquivalent)
//
//        XCTAssertEqual(NSDictionary(dictionary: d1), NSDictionary(dictionary: d2))
//            // Hey, this now also works on Linux! (Mason 2017-07-14)
    }
    
 
    func test_credential_roundtrip_JSON_serialization() {
        
        // This test predates our serialization testing convenience methods.
        
        let foo = CredentialsModel()
        foo.createDateTime   = 666
        foo.credentials      = ["accessKeyId": "access key bro", "secretAccessKey": "secret bro"]
        foo.credentialsId    = "credentials ID bro"
        foo.description      = "description bro"
        foo.lastUsedDateTime = 666
        foo.type             = .awsCredentials
        foo.updateDateTime   = 666
        
        guard let encoded = foo.toData(),
              let decoded = CredentialsModel.from(encoded)
        else {
            XCTFail()
            return
        }
        
        XCTAssert(decoded.createDateTime == 666)
        XCTAssert(decoded.credentials?["accessKeyId"] as? String == "access key bro")
        XCTAssert(decoded.credentials?["secretAccessKey"] as? String  == "secret bro")
        XCTAssert(decoded.description == "description bro")
        XCTAssert(decoded.lastUsedDateTime == 666)
        XCTAssert(decoded.type == .awsCredentials)
        XCTAssert(decoded.updateDateTime == 666)
    }
    
    
    func test_AuthResponse_init() {

        // This test is a port from the days before we had a strongly-typed API for decoding response payloads. We probably would not bother to write this test this way today.
        
        let good = [
            "apiKey"     : "some key",
            "token"      : "some token value",
            "operatorId" : "OP666",
        ].toData()
        
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


