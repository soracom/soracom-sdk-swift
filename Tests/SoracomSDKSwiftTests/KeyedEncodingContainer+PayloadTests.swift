// KeyedEncodingContainer+PayloadTests.swift Created by mason on 2017-07-28. 

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif


class KeyedEncodingContainerPayloadTests: BaseTestCase {
    
    func test_encode_arrays() {
        
        let p: RequestPayload = [
            .apn  : [1,2,3],
            .body : ["uno", "dos", "tres"],
            .code : [false, true, 1, 2, "F", "U"],
            .date : [
                [1,2,3],
                ["uno", "dos", "tres"],
                [false, true, 1, 2, "F", "U"],
                [["一", "二", "三", "四", "五"], ["💵", "💴"]]
            ]    
        ]
        
        let e = JSONEncoder()
        
        do {
            let d = try e.encode(p)
            print(d.utf8String ?? "💩")
            
            guard let decoded = try ResponsePayload(data: d) else {
                XCTFail("decode failed")
                return
            }
            print("\(decoded)")
            
            guard let intArray    = decoded[.apn] as? [Int],
                let stringArray = decoded[.body] as? [String],
                let mixedArray  = decoded[.code] as? [Any],
                let arrayArray  = decoded[.date] as? [[Any]]
                else {
                    XCTFail("decode failed (T_T)")
                    return
            }
            
            XCTAssertEqual(intArray, [1,2,3])
            XCTAssertEqual(stringArray, ["uno", "dos", "tres"])
            XCTAssertEqual(mixedArray[0] as? Bool, false)
            XCTAssertEqual(mixedArray[2] as? Int, 1)
            XCTAssertEqual(mixedArray[4] as? String, "F")
            
            let mixedChildArray  = arrayArray[2]; 
              // this one already guaranteed to exist
            
            guard let intChildArray  = arrayArray[0] as? [Int],
                let stringChildArray = arrayArray[1] as? [String],
                let arrayChildArray  = arrayArray[3] as? [[String]]
                else {
                    XCTFail("decode failed (T_T)")
                    return
            }
            XCTAssertEqual(intChildArray, [1,2,3])
            XCTAssertEqual(stringChildArray, ["uno", "dos", "tres"])
            XCTAssertEqual(mixedChildArray[0] as? Bool, false)
            XCTAssertEqual(mixedChildArray[2] as? Int, 1)
            XCTAssertEqual(mixedChildArray[4] as? String, "F")
            XCTAssertEqual(arrayChildArray[0], ["一", "二", "三", "四", "五"])
            XCTAssertEqual(arrayChildArray[1], ["💵", "💴"])
            
            
        } catch  {
            XCTFail("aw... \(error)")
            return
        }
        
    }
    
    
    
    
    func test_throws_when_asked_to_encode_bogus_type() {
        
        let p: RequestPayload = [.apiKey: self]
        let e = JSONEncoder()
        
        do {
            XCTAssertThrowsError(try e.encode(p)) { (error) -> Void in
                guard let err = error as? PayloadEncodeError else {
                    XCTFail("wrong error type: expected PayloadEncodeError but got: \(error)")
                    return;
                }
                switch err {
                case .invalidValueType(type: let t):
                    let expected = String(describing: t)
                    let actual   = String(describing: type(of: self))
                    XCTAssertEqual(expected, actual, "the invalid type indicated by the error was incorrect")
                default:
                    XCTFail("expected error case was not thrown")
                }
            }
        } 
    }
    
    
    func test_encode_dictionary_simple() {
        let p: RequestPayload = [
            .apiKey : "foo",
            .operatorId: [
                "userName" : "yep",
                "token" : [
                    "apiKey": "BORKMASTER"
                ]
            ]
        ]
        
        let e = JSONEncoder()
        
        do {
            let d = try e.encode(p)
            print(d.utf8String ?? "💩")
        } catch  {
            XCTFail("aw... \(error)")
            return
        }
    }

    
}


#if os(Linux)
    extension KeyedEncodingContainerPayloadTests {
        static var allTests : [(String, (KeyedEncodingContainerPayloadTests) -> () throws -> Void)] {
            return [
                ("test_encode_arrays", test_encode_arrays),
                ("test_throws_when_asked_to_encode_bogus_type", test_throws_when_asked_to_encode_bogus_type),
                ("test_encode_dictionary_simple", test_encode_dictionary_simple),
            ]
        }
    }
#endif 

