// ModelExtensionTests.swift Created by Mason Mark on 2018-08-14. Copyright © 2018 Soracom, Inc. All rights reserved.

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


class ModelExtensionTests: XCTestCase {
    
    /// sanity check test for custom initializer
    
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
    
    /// sanity check test for custom initializer

    func test_initialization_CredentialsModel() {
        
        let creds = CredentialsModel(description: "this is a test");
        XCTAssert(creds.description == "this is a test")
    }
    
    
}


#if os(Linux)
extension AuthRequestTests {
    static var allTests : [(String, (RequestAuthTests) -> () throws -> Void)] {
        return [
            ("test_initialization", test_initialization),
        ]
    }
}
#endif

