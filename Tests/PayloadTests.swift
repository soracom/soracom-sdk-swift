// APIDictionaryTests.swift Created by mason on 2016-03-25. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class PayloadTests: XCTestCase {
    

    func test_basic_set_and_get() {
        let d:Payload = [:]

        XCTAssert(d[.email] == nil)
        
        let foo = "foo@bar.com"
        d[.email] = foo
        
        if let s = d[.email] as? String {
            XCTAssertEqual(s, foo)
        } else {
            XCTFail("incorrect value for s")
        }
    }
    

    func test_set_up_with_dictionary_literal() {
        // Prove that initializing an Payload literally works as expected.
        let x: Payload = [
            .createDateTime   : "foo",
            .credentials      : "bar",
            .credentialsId    : "baz",
            .description      : "ass",
            .lastUsedDateTime : NSNumber(longLong: 7),
            .type             : "hat",
            .updateDateTime   : 1,
        ]
        
        XCTAssert(x[.createDateTime] as? String == "foo")
        XCTAssert(x[.lastUsedDateTime] as? NSNumber == 7)
        XCTAssert(x[.type] as? String == "hat")
        XCTAssert(x[.lastUsedDateTime] as? Int == 7)
    }
    
    
    func test_automagic_type_bridging() {
        // This is just a sanity-check test to make sure things actually work how Payload thinks they work.
        // See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html for info.

        let x: Payload = [
            .createDateTime   : "foo",
            .credentials      : "bar",
            .credentialsId    : "baz",
            .description      : "ass",
            .lastUsedDateTime : NSNumber(longLong: 7),
            .type             : "hat",
            .updateDateTime   : 1,
            ]
        
        let anInt   = x[.lastUsedDateTime] as? Int    // → 7
        let aUInt   = x[.lastUsedDateTime] as? UInt   // → 7
        let aFloat  = x[.lastUsedDateTime] as? Float  // → 7
        let aDouble = x[.lastUsedDateTime] as? Double // → 7
        let aBool   = x[.lastUsedDateTime] as? Bool   // → ?
        
        let tooBad  = x[.lastUsedDateTime] as? Int64  // → nil

        XCTAssert(anInt == 7)
        XCTAssert(aUInt == 7)
        XCTAssert(aFloat == 7)
        XCTAssert(aDouble == 7.0)
        XCTAssert(aBool == true)
        
        XCTAssert(tooBad == nil)
          // This is unfortnuate since I want all numbers to be 64-bit integers for this use case... but c'est la vie
    }
    
    
    func test_toDictionary() {
        let p: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : NSNumber(longLong: 5),
            .type           : "yes"
        ]
        
        guard let actual = p.toDictionary() else {
            XCTFail()
            return
        }
        
        let expected: [String:AnyObject] = [
            "email"          : "foo@bar.com",
            "updateDateTime" : NSNumber(longLong: 5),
            "type"           : "yes"
        ]
        XCTAssertEqual(actual as NSDictionary, expected as NSDictionary)
    }
    
    
    func test_toDictionary_extended_with_nested_payload() {
        
        let payload: Payload = [
            PayloadKey.name     : [.cvc: "fee fie foe fum", .authKey: 666] as Payload,
            PayloadKey.unixtime : "💩"
        ]
        
        guard let actual = payload.toDictionary() else {
            XCTFail()
            return
        }
        
        let expected: [String: AnyObject] = [
            "name"     : ["cvc" : "fee fie foe fum", "authKey": 666],
            "unixtime" : "💩"
        ]
        
        XCTAssertEqual(actual as NSDictionary, expected as NSDictionary)
    }
    
    
    func test_more_extended_nested_toDictionary() {
        let granddaughter: Payload = [
            .email   : "granddaughter@soracom.jp",
            ]
        
        let daughter: Payload = [
            .email        : "daughter@soracom.jp",
            .beamStatsMap : granddaughter
        ]
        
        let mama: Payload = [
            .email               : "mama@soracom.jp",
            .dataTrafficStatsMap : daughter
        ]
        
        guard let encoded = mama.toDictionary() else {
            XCTFail()
            return
        }

        guard let decoded = Payload.fromDictionary(encoded), recoded = decoded.toDictionary() else {
            XCTFail()
            return
        }
        XCTAssertEqual(encoded as NSDictionary, recoded as NSDictionary)
    }

    
    
    func test_fromDictionary() {
        let d = [
            "email"          : "foo@bar.com",
            "updateDateTime" : NSNumber(longLong: 5),
            "type"           : "yes"
        ]

        let expected: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : NSNumber(longLong: 5),
            .type           : "yes"
        ]
        
        let actual       =  Payload.fromDictionary(d)
        
        if let actual = actual {
            guard let actualDict = actual.toDictionary(), expectedDict = expected.toDictionary() else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(actualDict as NSDictionary, expectedDict as NSDictionary)
            
        } else {
            XCTFail("bogus condition")
        }
    }
    
    
    // Mason 2016-06-09: commented out this test below, because today I changed the behavior of fromDictionary(). It no longer throws. However, leaving this here for now because we might change this behavior again... 
    //    func test_fromDictionary_bogus() {
    //        var gotError = false
    //        do {
    //            let nope = Payload.fromDictionary(["nonexistent key": "nonexistent key"])
    //            XCTFail("expected error to be thrown, precluding getting here \(nope)")
    //        } catch {
    //            gotError = true
    //        }
    //       XCTAssertTrue(gotError)
    //    }
    
    
    func test_equatable() {
        let one: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : NSNumber(longLong: 5),
            .type           : "yes"
        ]
        
        let two: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : NSNumber(longLong: 5),
            .type           : "yes"
        ]
        
        let three: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : NSNumber(longLong: 5),
            .type           : "♬ one of these kids is doing his own thing..."
        ]
        
        XCTAssert(one == two)
        XCTAssert(one != three)
        XCTAssert(three == three)
    }
    
    
    func test_array_support_1() {
        let obj1    = AirStatsForSpeedClass(uploadBytes: 1, uploadPackets: 1, downloadBytes: 1, downloadPackets: 1)
        let obj2    = AirStatsForSpeedClass(uploadBytes: 2, uploadPackets: 2, downloadBytes: 2, downloadPackets: 2)
        let payload = Payload(list: [obj1, obj2])
        
        guard let actual = payload.toJSON() else {
            XCTFail("no JSON generated")
            return
        }
        
        let expected = "[\n  {\n    \"downloadByteSizeTotal\" : 1,\n    \"downloadPacketSizeTotal\" : 1,\n    \"uploadByteSizeTotal\" : 1,\n    \"uploadPacketSizeTotal\" : 1\n  },\n  {\n    \"downloadByteSizeTotal\" : 2,\n    \"downloadPacketSizeTotal\" : 2,\n    \"uploadByteSizeTotal\" : 2,\n    \"uploadPacketSizeTotal\" : 2\n  }\n]"
        
        XCTAssertEqual(expected, actual)
    }
    
    
    func test_array_conversion_simple() {
        
        let source: [Any]          = [1, "a", ["foo": "bar"], ["baz"]]
        let expected: [AnyObject]  = [1, "a", ["foo": "bar"], ["baz"]]
        
        let p1 = Payload(list: source)
        
        guard let actual = p1.toArray() else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(expected as NSArray, actual as NSArray)
    }
    
    
    func test_subscriber_conversion() {
        
        let source: Payload = [
            .ipAddress  : "0.1.2.3",
            .speedClass : SpeedClass.s1_fast.rawValue,
            .imsi       : "470010171566423"
        ] // just because aotw this is easiest way to create a Subscriber
        
        let sub = Subscriber.from(source)
        
        let payload = Payload(list: [sub, sub])
        
        guard let actual = payload.toArray() else {
            XCTFail()
            return
        }
        
        let expected: [AnyObject] = [["ipAddress": "0.1.2.3", "speedClass": "s1.fast", "imsi": "470010171566423"],["ipAddress": "0.1.2.3", "speedClass": "s1.fast", "imsi": "470010171566423"]]
        
        XCTAssertEqual(expected as NSArray, actual as NSArray)
    }
    
    
}
