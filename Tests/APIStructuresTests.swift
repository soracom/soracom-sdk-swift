// APIStructuresTests.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class APIStructuresTests: BaseTestCase {
    
    func test_AirStats_serialization() {
        
        let fast  = AirStatsForSpeedClass(uploadBytes: 5, uploadPackets: 55, downloadBytes: 555, downloadPackets: 5555)
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
        
        guard let d1 = actual.toDictionary(), d2 = expected.toDictionary() else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(d1 as NSDictionary, d2 as NSDictionary)
    }
    
 
    func test_credentials_JSON_seriliazation() {
        
        let foo = Credential()
        let bar = foo.toPayload()
        let baz = bar.toJSON()
        
        do {
            // This unwieldy junk is pretty terrible, but the round-trip synchronization that would make this kind 
            // of test better and prettier isn't yet implemented for PayloadConvertible.
            
            if let data = baz?.dataUsingEncoding(NSUTF8StringEncoding) {
                let decoded = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                
                XCTAssertNotNil(decoded)
                XCTAssertNotNil(decoded["credentialsId"])
                XCTAssertNotNil(decoded["type"])
                
            } else {
                throw NSError(domain: "yuck", code: 666, userInfo: nil)
            }
        } catch {
            XCTFail("test got unexpected error \(error)")
        }
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
        
        XCTAssertNil( AuthResponse(bad) )
        
        let a = AuthResponse(good)
        
        XCTAssertNotNil(a)
        
    }
    
}
