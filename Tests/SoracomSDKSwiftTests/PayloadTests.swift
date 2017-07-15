// APIDictionaryTests.swift Created by mason on 2016-03-25. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif

class PayloadTests: BaseTestCase {
    

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
            .lastUsedDateTime : 7,
            .type             : "hat",
            .updateDateTime   : 1,
        ]
        
        XCTAssert(x[.createDateTime] as? String == "foo")
        XCTAssert(x[.lastUsedDateTime] as? Int == 7)
        XCTAssert(x[.type] as? String == "hat")
    }
    
    
//    func test_automagic_type_bridging() {
//        // This is just a sanity-check test to make sure things actually work how Payload thinks they work.
//        // See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html for info.
//
//        let x: Payload = [
//            .createDateTime   : "foo",
//            .credentials      : "bar",
//            .credentialsId    : "baz",
//            .description      : "ass",
//            .lastUsedDateTime : 7,
//            .type             : "hat",
//            .updateDateTime   : 1,
//            ]
//        
//        let anInt   = x[.lastUsedDateTime] as? Int    // → 7
//        let aUInt   = x[.lastUsedDateTime] as? UInt   // → 7
//        let aFloat  = x[.lastUsedDateTime] as? Float  // → 7
//        let aDouble = x[.lastUsedDateTime] as? Double // → 7
//        let aBool   = x[.lastUsedDateTime] as? Bool   // → nil (as of Swift 4)
//        
//        XCTAssertEqual(anInt, 7)
//        XCTAssertEqual(aUInt, 7)
//        XCTAssertEqual(aFloat, 7)
//        XCTAssertEqual(aDouble, 7.0)
//        XCTAssertNil(aBool)
//        
//        // Mason 2017-02-10: This old test below started failing on Swift 3.1, because NSNumber can now apparently give you an Int64 just as easily as an Int. Which is great, if true, but I haven't found anywhere this change is documented yet...
//        //
//        //        let tooBad  = x[.lastUsedDateTime] as? Int64  // → nil
//        //        XCTAssert(tooBad == nil)
//        //          // This is unfortnuate since I want all numbers to be 64-bit integers for this use case... but c'est la vie
//        
//        let wooHooNowIn2017ThisWorks = x[.lastUsedDateTime] as? Int64  // → 7
//        XCTAssert(wooHooNowIn2017ThisWorks == 7)
//        
//        // Mason 2017-02-10 (one hour later, haha): I think it doesn't really matter anyway, because:
//        //    Swift Dev. 3.1 (Feb 7, 2017)
//        //    Platform: Linux (x86_64)
//        //    /swift-execution/Sources/main.swift:9:22: warning: cast from 'NSNumber' to unrelated type 'Int64' always fails
//        //    let hoberstank = bar as? Int64
//        //    ~~~ ^   ~~~~~
//        //
//        // ...so probably that relies on automagic bridging and will only work on objc-ish platforms(?)
//        
//        // MASON 2017-07-13: YES THIS TOTALLY DOESN'T WORK ON LINUX; NUKE IT
//    }
    
    
    func test_toDictionary() {
        let p: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : 5,
            .type           : "yes"
        ]
        
        guard let actual = p.toDictionary() else {
            XCTFail()
            return
        }
        
//        let expected: [String:Any] = [
//            "email"          : "foo@bar.com",
//            "updateDateTime" : NSNumber(value: 5),
//            "type"           : "yes"
//        ]
        
        // XCTAssertEqual(actual as NSDictionary, expected as NSDictionary)
        
        XCTAssertEqual(actual["email"] as? String, "foo@bar.com")
        XCTAssertEqual(actual["updateDateTime"] as? Int, 5)
        XCTAssertEqual(actual["type"] as? String, "yes")
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
        
//        let expected: [String: Any] = [
//            "name"     : ["cvc" : "fee fie foe fum", "authKey": 666],
//            "unixtime" : "💩"
//        ]
        
        // XCTAssertEqual(actual as NSDictionary, expected as NSDictionary)
        let nested = actual["name"] as? Dictionary<String, Any>
        XCTAssertEqual(nested?["cvc"] as? String, "fee fie foe fum")
        XCTAssertEqual(nested?["authKey"] as? Int, 666)
        XCTAssertEqual(actual["unixtime"] as? String, "💩")
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

        guard let decoded = Payload.fromDictionary(encoded), let recoded = decoded.toDictionary() else {
            XCTFail()
            return
        }
        //XCTAssertEqual(encoded as NSDictionary, recoded as NSDictionary)
        XCTAssertEqual(recoded["email"] as? String,  "mama@soracom.jp")
        // FIXME: handle the rest of the comparison NSDictionary used to do for us
    }

    
    func test_linux_JSONSerialization_vs_Int64() {

        #if os(Linux)
            let bigInt: Int64 = 555_555_555_555_555_555
            let src = ["foo": 5, "bar": bigInt]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: src, options: .prettyPrinted)
                print(jsonData)
                XCTFail() // if we get here, no error occurred.. I'm testing the assumption that JSONSerialization can't serialize Int64
            } catch {
                print(error)
            }
        #endif
    }
    
    func test_fromDictionary() {
        let d: [String:Any] = [
            "email"          : "foo@bar.com",
            "updateDateTime" : 5,
            "type"           : "yes"
        ]

        //let five: Int64 = 5 // can we do this as of swiftlang-800.0.43.6 ?? (Yes, woo hoo! But it breaks the isEqual test so don't do it here...)
        
//        let expected: Payload = [
//            .email          : "foo@bar.com",
//            .updateDateTime : 5,
//            .type           : "yes"
//        ]
        
        let actual       =  Payload.fromDictionary(d)
        
        if let actual = actual {
            guard let actualDict = actual.toDictionary() else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(actualDict["email"] as? String, "foo@bar.com")
            XCTAssertEqual(actualDict["updateDateTime"] as? Int, 5)
            XCTAssertEqual(actualDict["type"] as? String, "yes")
            
            
        } else {
            XCTFail("bogus condition")
        }
    }
    
    func test_encodeInt64() {
        
        // This was added to test swiftlang-800.0.43.6 ; comments implied maybe they had made Int64 auto-bridge
        // to NSNumber like Int does. However this was not the case. So, even though we added support for Int64
        // to Payload, that applies only when constructing them locally... there is no way to get an Int64 out 
        // of a Payload received over the network other than getting it `as? NSNumber` and then asking for its
        // int64Value...
        
        let regularInt = 666
        let bigInt: Int64 = 500_000_000_000_001
        
        let p: Payload = [
            .amount: regularInt,
            .unixtime: bigInt
        ]
        
        guard let encoded = p.toJSONData() else {
            XCTFail("could not JSON-encode Payload containing Int64")
            return
        }
        
        XCTAssert(encoded.count > 0)
        
//        let decoded = Payload(data: encoded)
        
        
        guard let p2 = roundTripSerializeDeserialize(p)?.toPayload() else {
            XCTFail("roundTripSerializeDeserialize() failed for \(p)")
            return
        }
        guard let amount = p2[.amount] as? Int, let unixtime = p2[.unixtime] as? Int else {
            XCTFail()
            return
        }
        XCTAssert(amount == Int(regularInt))
        XCTAssert(unixtime == Int(bigInt))
        
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
            .updateDateTime : 5,
            .type           : "yes"
        ]
        
        let two: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : 5,
            .type           : "yes"
        ]
        
        let three: Payload = [
            .email          : "foo@bar.com",
            .updateDateTime : 5,
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
        
        // XCTAssertEqual(expected, actual) // ← so fragile! works but breaks with every OS update... so I wrote isEquivalentJSON() instead:
        
        let isEquivalent = isEquivalentJSON(actual, expected)
        XCTAssertTrue(isEquivalent)
    }
    
    
    func test_array_conversion_simple() {
        
        let source: [Any]    = [1, "a", ["foo": "bar"], ["baz"]]
//        let expected: [Any]  = [1, "a", ["foo": "bar"], ["baz"]]
        
        let p1 = Payload(list: source)
        
        guard let actual = p1.toArray() else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(actual[0] as? Int, 1)
        XCTAssertEqual(actual[1] as? String, "a")
        XCTAssertEqual((actual[2] as? [String:String])!, ["foo": "bar"])
        XCTAssertEqual((actual[3] as? [String])!, ["baz"])
    }
    
    
    func test_subscriber_conversion() {
        
        // FIXME: this test is pretty bogus and based on old Payload stuff... Codable+SoracomSDK has
        // the new stuff. We should rewrite this test once the Codable conversion is done.
        
        let source: Payload = [
            .speedClass : SpeedClass.s1_fast.rawValue,
            .imsi       : "470010171566423"
        ] // just because aotw this is easiest way to create a Subscriber
        
        guard let sub = Subscriber.from(source) else {
            XCTFail()
            return
        }
        
        let payload = Payload(list: [sub, sub])
        
        guard let actual = payload.toArray() as? [[String:String]] else {
            XCTFail()
            return
        }
        
        let expected: [[String:String]] = [["speedClass": "s1.fast", "imsi": "470010171566423"],["speedClass": "s1.fast", "imsi": "470010171566423"]]
        
        XCTAssertEqual(expected[0], actual[0])
        XCTAssertEqual(expected[1], actual[1])
    }
    
}


#if os(Linux)
    extension PayloadTests {
        static var allTests : [(String, (PayloadTests) -> () throws -> Void)] {
            return [
                ("test_basic_set_and_get", test_basic_set_and_get),
                ("test_set_up_with_dictionary_literal", test_set_up_with_dictionary_literal),
                ("test_toDictionary_extended_with_nested_payload", test_toDictionary_extended_with_nested_payload),
                ("test_more_extended_nested_toDictionary", test_more_extended_nested_toDictionary),
                ("test_linux_JSONSerialization_vs_Int64", test_linux_JSONSerialization_vs_Int64),
                ("test_fromDictionary", test_fromDictionary),
                ("test_encodeInt64", test_encodeInt64),
                ("test_equatable", test_equatable),
                ("test_array_support_1", test_array_support_1),
                ("test_array_conversion_simple", test_array_conversion_simple),
                ("test_subscriber_conversion", test_subscriber_conversion),
            ]
        }
    }
#endif 


