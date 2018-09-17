// ModelExtensionTests.swift Created by Mason Mark on 2018-08-14. Copyright © 2018 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif

class ModelExtensionTests: XCTestCase {
    
    /// sanity check test for SoracomCredentials custom initializer
    
    func test_initialization() {
        
        let creds = SoracomCredentials(authKeyId: "keyId-foo-hoge", authKeySecret: "keyId-bar-hoge")
        
        guard
            let authReq = AuthRequest(from: creds),
            let id      = authReq.authKeyId,
            let key     = authReq.authKey
        else {
            return XCTFail()
        }
        XCTAssert(id == "keyId-foo-hoge")
        XCTAssert(key == "keyId-bar-hoge")
    }
    
    /// sanity check test for CredentialsModel custom initializer

    func test_initialization_CredentialsModel() {
        
        let creds = CredentialsModel(description: "this is a test");
        XCTAssert(creds.description == "this is a test")
    }
    
}


#if os(Linux)
extension ModelExtensionTests {
    static var allTests : [(String, (ModelExtensionTests) -> () throws -> Void)] {
        return [
            ("test_initialization", test_initialization),
            ("test_initialization_CredentialsModel", test_initialization_CredentialsModel),
        ]
    }
}
#endif

