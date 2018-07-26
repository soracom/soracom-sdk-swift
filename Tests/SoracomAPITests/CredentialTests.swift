// CredentialTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_MAC_DEMO_APP
    // Do nothing (it's magic). We unfortunately need 3 different import 
    // modes: Xcode+macOS, Xcode+iOS, and non-Xcode ("swift test" CLI) 
    // due to macOS and iOS not supporting SPM build/test...
#elseif USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomSDK
#else
    @testable import SoracomAPI 
#endif

class CredentialTests: BaseTestCase {
    
    var awesome: CredentialsModel {
        return CredentialsModel(
            createDateTime: 666, 
            credentials: ["accessKeyId": "foo-id", "secretAccessKey": "bar-secret"],
            credentialsId: "awesome-credentials-id", 
            description: "Some words about my credentials bro", 
            lastUsedDateTime: 667, 
            type: .awsCredentials,
            updateDateTime: 667
        )
    }
    
    var bodacious: CredentialsModel {
        return CredentialsModel(
            createDateTime: 1666, 
            credentials: ["accessKeyId": "hoge-id", "secretAccessKey": "derp-secret"],
            credentialsId: "bodacious-credentials-id", 
            description: "Some other words about my credentials bro", 
            lastUsedDateTime: 1667, 
            type: .azureCredentials,
            updateDateTime: 1667
        )
    }
    
    var consummate: CredentialsModel {
        return CredentialsModel(
            createDateTime: 11666, 
            credentials: ["accessKeyId": "bunga-id", "secretAccessKey": "bunga-secret"],
            credentialsId: "consummate-credentials-id", 
            description: "Some different words about my credentials bro", 
            lastUsedDateTime: 11667, 
            type: .x509,
            updateDateTime: 11667
        )
    }
    
    
    func test_serialize() {
        let c  = CredentialsModel(description: "my awesome credential bro")
        
        guard let c2 = roundTripSerializeDeserialize(c) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(c2.description,  "my awesome credential bro")
    }
    
    
    func test_serialize_list() {
        
        // This is an old test from before Swift 4 and codable.
        // It does the same job as test_codable_serialization_of_array_via_data below.
        
        let a = CredentialsModel(description: "awesome credential")
        let b = CredentialsModel(description: "bodacious credential")
        let c = CredentialsModel(description: "consummate credential")
        
        let outgoing = Payload(list: [a,b,c])
        
        guard let incoming = roundTripSerializeDeserialize_OBSOLETE_PAYLOAD_VERSION(outgoing),
              let list = CredentialsModel.listFrom(incoming.toPayload())
        else {
            XCTFail()
            return
        }
        
        print(list)
        
        guard list.count == 3 else {
            XCTFail("list decode failed")
            return
        }
        
        XCTAssertEqual(list[0].description, "awesome credential")
        XCTAssertEqual(list[1].description, "bodacious credential")
        XCTAssertEqual(list[2].description, "consummate credential")
    }
    
    
    func test_codable_serialization_of_array_via_data() {
        
        let list = [
            awesome,
            bodacious,
            consummate
        ]
        
        guard let encoded = list.toData() else {
            XCTFail("[Credential].toData() failed to encode")
            return;
        }
        
        guard let decoded = CredentialsModel.listFrom(encoded) else {
            XCTFail("failed to decode Credential list from data")
            return;
        }
        
        guard decoded.count == 3 else {
            XCTFail("bogus decoded Credentials list")
            return
        }
        
        let a = decoded[0]
        let b = decoded[1]
        let c = decoded[2]
        
        XCTAssertEqual(a.credentials?["secretAccessKey"] as? String, "bar-secret")
        XCTAssertEqual(b.credentials?["secretAccessKey"] as? String, "derp-secret")
        XCTAssertEqual(c.credentials?["secretAccessKey"] as? String, "bunga-secret")
        
        XCTAssertEqual(a.type, .awsCredentials)
        XCTAssertEqual(b.type, .azureCredentials)
        XCTAssertEqual(c.type, .x509)
        
        XCTAssertEqual(a.lastUsedDateTime, 667)
        XCTAssertEqual(b.lastUsedDateTime, 1667)
        XCTAssertEqual(c.lastUsedDateTime, 11667)
    }
    
    
    func test_codable_serialization_of_array_via_payload() {
        // Same test as above, but exercises the payload serialization path
        
        let list = [
            awesome,
            bodacious,
            consummate
        ]
        
        let encoded = list.toPayload()
        
        guard let decoded = CredentialsModel.listFrom(encoded) else {
            XCTFail("failed to decode Credential list from Payload")
            return;
        }
        
        guard decoded.count == 3 else {
            XCTFail("bogus decoded Credentials list")
            return
        }
        
        let a = decoded[0]
        let b = decoded[1]
        let c = decoded[2]
        
        XCTAssertEqual(a.credentials?["secretAccessKey"] as? String, "bar-secret")
        XCTAssertEqual(b.credentials?["secretAccessKey"] as? String, "derp-secret")
        XCTAssertEqual(c.credentials?["secretAccessKey"] as? String, "bunga-secret")
        
        XCTAssertEqual(a.type, .awsCredentials)
        XCTAssertEqual(b.type, .azureCredentials)
        XCTAssertEqual(c.type, .x509)
        
        XCTAssertEqual(a.lastUsedDateTime, 667)
        XCTAssertEqual(b.lastUsedDateTime, 1667)
        XCTAssertEqual(c.lastUsedDateTime, 11667)

    }
    
    func test_codable_serialization_via_payload() {
        
        let encoded = bodacious.toPayload()
        guard let decoded = CredentialsModel.from(encoded) else {
            XCTFail("failed to decode Credential object from Payload")
            return;
        }
        
        XCTAssertEqual(decoded.credentials?["secretAccessKey"] as? String, "derp-secret")
        XCTAssertEqual(decoded.type, .azureCredentials)
        XCTAssertEqual(decoded.lastUsedDateTime, 1667)
    }
    
    
    func test_codable_serialization_via_data() {
        
        guard let encoded = bodacious.toData() else {
            XCTFail("failed to encode Credential object as data")
            return;
        }
        guard let decoded = CredentialsModel.from(encoded) else {
            XCTFail("failed to decode Credential object from data")
            return;
        }
        
        XCTAssertEqual(decoded.credentials?["secretAccessKey"] as? String, "derp-secret")
        XCTAssertEqual(decoded.type, .azureCredentials)
        XCTAssertEqual(decoded.lastUsedDateTime, 1667)
    }
    
    
    func test_junk() {
    
        let c  = CredentialsModel(
            createDateTime: 666, 
            credentials: ["accessKeyId": "foo-id", "secretAccessKey": "bar-secret"],
            credentialsId: "super-credentials-id", 
            description: "Some words about my credentials bro", 
            lastUsedDateTime: 667, 
            type: .x509, 
            updateDateTime: 667
        )
        
        let e = JSONEncoder()
        // e.outputFormatting = [.prettyPrinted, .sortedKeys] // .sortedKeys doesn't work on Linux aotw 2017-07-14
        e.outputFormatting = [.prettyPrinted]
        
        let d = try! e.encode(c)
        let j = d.utf8String ?? "error bro!"
                
        print("HI BRO")
        print(j)
    }
    
}

#if os(Linux)
    extension CredentialTests {
        static var allTests : [(String, (CredentialTests) -> () throws -> Void)] {
            return [
                ("test_serialize", test_serialize),
                ("test_serialize_list", test_serialize_list),
                ("test_codable_serialization_of_array_via_data", test_codable_serialization_of_array_via_data),
                ("test_codable_serialization_of_array_via_payload", test_codable_serialization_of_array_via_payload),
                ("test_codable_serialization_via_payload", test_codable_serialization_via_payload),
                ("test_codable_serialization_via_data", test_codable_serialization_via_data),
                ("test_junk", test_junk),
            ]
        }
    }
#endif 

