// Request+CredentialsTests.swift Created by mason on 2016-04-15. Copyright © 2016 Soracom, Inc. All rights reserved.

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

class RequestCredentialsTests: BaseTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        self.continueAfterFailure = false
        
        guard !Client.sharedInstance.credentialsForSandboxUser.blank else {
            // API Sandbox user can be created automatically as needed, but only
            // if production SAM user credentials have been stored.
            // For the SDK demo apps, you can use the GUI to save these credentials;
            // otherwise, you can do it in the debugger.
            //
            // See Client.doInitialHousekeeping() for details
            
            XCTFail("Cannot run \(self) because no credentials are available. See test method comments for details.")
            
            return
        }
    }
    
    
    /// Multi step CRUD test.
    
    func test_CRUD_credentials() {
        
        let junk    = UUID().uuidString
        let creds   = ["accessKeyId": "foo", "secretAccessKey": "bar"]
        let options = CreateAndUpdateCredentialsModel(credentials: creds, description: "test_CRUD_credentials", type: .awsCredentials)
        
        // CREATE:
        let createRequest  = Request.createCredential(credentials: options, credentialsId: junk)
        let createResponse = createRequest.wait()
        
        XCTAssertNil(createResponse.error)
        
        //        let created = CredentialsModel.from(createResponse.payload)
        let created = createResponse.parse()

        XCTAssertNotNil(created)
        XCTAssertNotNil(created?.credentials)
        XCTAssertEqual("test_CRUD_credentials", created?.description)
        XCTAssertEqual("foo", created?.credentials?["accessKeyId"] as? String)
        XCTAssertEqual(junk, created?.credentialsId)
        
        XCTAssertNotNil(findCredential(junk))
        
        options.description = "updated description"
        
        // UPDATE:
        let updateRequest  = Request.updateCredential(credentials: options, credentialsId: junk)
        let updateResponse = updateRequest.wait()
        
        XCTAssertNil(updateResponse.error)
        
        let updated = findCredential(junk)
        XCTAssertEqual("updated description", updated?.description)
        
        // DELETE:
        let deleteRequest  = Request.deleteCredential(credentialsId: junk)
        let deleteResponse = deleteRequest.wait()
        
        XCTAssertNil(deleteResponse.error)
        XCTAssertNil(findCredential(junk))
    }
    
    
    func listCredentials() -> [CredentialsModel]? {
        
        let listRequest  = Request.listCredentials()
        let listResponse = listRequest.wait()
        
        guard let credList = listResponse.parse() else {
            XCTFail()
            return nil
        }
        
        return credList
    }
    
    
    func findCredential(_ id: String) -> CredentialsModel? {
        
        guard let list = listCredentials() else {
            XCTFail()
            return nil
        }
        
        var found: CredentialsModel? = nil
        
        for cred in list {
            if cred.credentialsId == id {
                found = cred
                break
            }
        }
        return found
    }

}

#if os(Linux)
    extension RequestCredentialsTests {
        static var allTests : [(String, (RequestCredentialsTests) -> () throws -> Void)] {
            return [
                ("test_CRUD_credentials", test_CRUD_credentials),
            ]
        }
    }
#endif

