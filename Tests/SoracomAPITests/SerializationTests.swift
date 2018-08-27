// SerializationTests.swift Created by mason on 2017-07-18. Copyright © 2017 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif


class SerializationTests: BaseTestCase {
    
    func test_serialize_AuthResponse() {
        
        let ar1 = AuthResponse(
            apiKey:     "just the good ol' boys",
            operatorId: "beats all you never saw, been in trouble with the law", token:      "never meanin' no harm",
            userName:   "since the day they was born"
        )
        
        guard let ar2  = roundTripSerializeDeserialize(ar1) else {
            XCTFail()
            return
        }
        XCTAssertEqual(ar2.apiKey,     "just the good ol' boys")
        XCTAssertEqual(ar2.token,      "never meanin' no harm")
        XCTAssertEqual(ar2.operatorId, "beats all you never saw, been in trouble with the law")
        XCTAssertEqual(ar2.userName,   "since the day they was born")
    }
    
    
//    func test_serialize_AirStats() {
//        
//        let stats1 = DataTrafficStats(downloadByteSizeTotal: 1, downloadPacketSizeTotal: 2, uploadByteSizeTotal: 3, uploadPacketSizeTotal: 4)
//        let stats2 = DataTrafficStats(downloadByteSizeTotal: 1, downloadPacketSizeTotal: 2, uploadByteSizeTotal: 3, uploadPacketSizeTotal: 4)
//        
//        let map1   = DataTrafficStatsMap(s1_fast: stats1, s1_minimum: stats2, s1_slow: stats1, s1_standard: stats2)
//        let map2   = DataTrafficStatsMap(s1_fast: stats2, s1_minimum: stats2, s1_slow: stats1, s1_standard: stats2)
//        
//        // FIXME: AirStats is gone but MapstringDataTrafficStats needs some human intervention
//
//
////        let uno = AirStatsResponse(dataTrafficStatsMap: map1, unixtime: 8675309)
////        let dos = AirStatsResponse(dataTrafficStatsMap: map2, unixtime: 8675309)
//        
//        guard let json1 = uno.toData()?.utf8String,
//              let json2 = dos.toData()?.utf8String
//        else {
//            XCTFail()
//            return
//        }
//        let isEquivalent = isEquivalentJSON(json1, json2)
//        XCTAssert(isEquivalent)
//        
//        guard let un   = roundTripSerializeDeserialize(uno),
//              let deux = roundTripSerializeDeserialize(dos)
//        else {
//            XCTFail()
//            return
//        }
//        
//        XCTAssertEqual(un.dataTrafficStatsMap.s1_standard?.downloadPacketSizeTotal, 2);
//        XCTAssertEqual(deux.dataTrafficStatsMap.s1_fast?.uploadPacketSizeTotal, 4);
//    }
    
    
    func test_serialize_DataTrafficStats() {
        
        let uno = DataTrafficStats(downloadByteSizeTotal: 1, downloadPacketSizeTotal: 2, uploadByteSizeTotal: 3, uploadPacketSizeTotal: 4)
        let dos = DataTrafficStats(downloadByteSizeTotal: 1, downloadPacketSizeTotal: 2, uploadByteSizeTotal: 3, uploadPacketSizeTotal: 4)
        
        guard let json1 = uno.toData()?.utf8String,
            let json2 = dos.toData()?.utf8String
            else {
                XCTFail()
                return
        }
        let isEquivalent = isEquivalentJSON(json1, json2)
        XCTAssert(isEquivalent)
        
        guard let un   = roundTripSerializeDeserialize(uno),
              let deux = roundTripSerializeDeserialize(dos)
        else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(un.downloadPacketSizeTotal, 2);
        XCTAssertEqual(deux.uploadPacketSizeTotal, 4);
    }
    
    
    func test_seralize_Tag() {
        
        let uno = TagUpdateRequest(tagName: "foo", tagValue: "bar")
        let dos = TagUpdateRequest(tagName: "baz", tagValue: "ホゲ")

        guard let eins = roundTripSerializeDeserialize(uno),
              let zwei = roundTripSerializeDeserialize(dos)
        else {
            XCTFail()
            return
        }
        XCTAssertEqual(eins.tagName,  "foo");
        XCTAssertEqual(eins.tagValue, "bar");
        XCTAssertEqual(zwei.tagName,  "baz");
        XCTAssertEqual(zwei.tagValue, "ホゲ");
    }
    
    // Mason 2017-07-26: The below was intended to demonstrate a bug in JSONEncoder. I did
    // report the bug, but the relevant Apple engineer indicated the problematic encoding
    // is an intentional design decision: https://bugs.swift.org/browse/SR-5504
    //
    //    // JSONEncoder gives strange results when encoding a dictionary whose
    //    // keys are (String-conforming) enum values. Here I demonstrate via
    //    // two unit tests.
    //
    //    func test_serialize_string_to_string_dictionary() {
    //
    //        // This test case is the working case. Everything
    //        // works as expected when encoding a [String:String]
    //        // dictionary:
    //
    //        let source: [String:String] = ["foo": "bar", "baz": "hoge"]
    //        let data = try! JSONEncoder().encode(source)
    //        let text = String(data: data, encoding: .utf8)!
    //
    //        print(text)
    //        // result: {"baz":"hoge","foo":"bar"}
    //        // That's the result one would expect
    //
    //        XCTAssert(text.contains(":")) // Passes.
    //
    //        let type    = [String:String].self
    //        let decoded = try? JSONDecoder().decode(type, from: data)
    //
    //        XCTAssertNotNil(decoded) // Passes
    //
    //        let decoded2 = try? JSONSerialization.jsonObject(with: data)
    //        // Use JSONSerialization as an example of "another system
    //        // trying to parse the JSON". It will get an array, not
    //        // a dictionary.
    //
    //        #if os(Linux)
    //            let decodedArray = decoded2 as? [String]
    //            let decodedDictionary = decoded2 as? [String:String]
    //        #else
    //            let decodedArray = decoded2 as? NSArray
    //            let decodedDictionary = decoded2 as? NSDictionary
    //        #endif
    //        XCTAssertNil(decodedArray)         // Passes.
    //        XCTAssertNotNil(decodedDictionary) // Passes.
    //    }
    //
    //    enum Fruit: String, Codable {
    //        case apple
    //        case banana
    //    }
    //
    //    func test_serialize_enum_to_string_dictionary() {
    //
    //        // This test case is the failing case. When
    //        // encoding a [Fruit:String] dictionary, the
    //        // JSON output is an array structure:
    //
    //        let source: [Fruit:String] = [.apple: "red", .banana: "yellow"]
    //        let data = try! JSONEncoder().encode(source)
    //        let text = String(data: data, encoding: .utf8)!
    //
    //        print(text)
    //        // result: ["apple","red","banana","yellow"]
    //        //
    //        // Result should have been: {"apple":"red","banana":"yellow"}
    //
    //        XCTAssert(text.contains(":")) // Fails.
    //
    //        let type    = [Fruit:String].self
    //        let decoded = try? JSONDecoder().decode(type, from: data)
    //
    //        XCTAssertEqual(decoded?[.apple], "red") // Passes.
    //        // This second test does pass, so JSONDecoder can, in fact,
    //        // decode the object. Which is interesting, but doesn't help
    //        // if you are e.g. sending the JSON to an external
    //        // application or API.
    //
    //        let decoded2 = try? JSONSerialization.jsonObject(with: data)
    //        // Use JSONSerialization as an example of "another system
    //        // trying to parse the JSON". It will get an array, not
    //        // a dictionary.
    //
    //        #if os(Linux)
    //            let decodedArray = decoded2 as? [String]
    //            let decodedDictionary = decoded2 as? [String:String]
    //        #else
    //            let decodedArray = decoded2 as? NSArray
    //            let decodedDictionary = decoded2 as? NSDictionary
    //        #endif
    //        XCTAssertNil(decodedArray)         // Fails.
    //        XCTAssertNotNil(decodedDictionary) // Fails.
    //    }
    
}

#if os(Linux)
    extension SerializationTests {
        static var allTests : [(String, (SerializationTests) -> () throws -> Void)] {
            return [
                ("test_serialize_AuthResponse", test_serialize_AuthResponse),
                ("test_serialize_AirStats", test_serialize_AirStats),
                ("test_serialize_DataTrafficStats", test_serialize_DataTrafficStats),
                ("test_seralize_Tag", test_seralize_Tag),
            ]
        }
    }
#endif
